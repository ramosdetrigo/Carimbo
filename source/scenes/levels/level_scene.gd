class_name LevelScene
extends Node3D

@export var exit_door: SceneDoor

@export var starting_dialog: DialogueResource
var enemy_count: int = 0:
	set(v): enemy_count = v; if enemy_count <= 0 and exit_door: exit_door.unlock()

func _ready() -> void:
	if starting_dialog:
		DialogueManager.show_dialogue_balloon(starting_dialog)
	if exit_door: exit_door.lock()
	var es: Array[Node] = get_tree().get_nodes_in_group(BeehaveConsts.MONSTER_NODE_GROUP)
	enemy_count = es.size()
	for enemy: EnemyCharacter in es:
		enemy.dead.connect(reduce, CONNECT_ONE_SHOT)


func reduce() -> void: enemy_count -= 1
