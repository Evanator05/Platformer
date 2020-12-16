extends Node2D

const MAX_PLAYERS = 2

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	

func _on_ButtonHost_pressed():
	var PORT = $ServerPort.text
	var net = NetworkedMultiplayerENet.new()
	net.create_server(int(PORT) , MAX_PLAYERS)
	get_tree().set_network_peer(net)
	print("hosting on port " + PORT)


func _on_ButtonJoin_pressed():
	var PORT = $HostPort.text
	var SERVERIP = $HostIp.text
	var net = NetworkedMultiplayerENet.new()
	net.create_client(SERVERIP, int(PORT))
	get_tree().set_network_peer(net)
	print("joining server " + SERVERIP + " " + PORT)

func _player_connected(id):
	Globals.player2id = id
	var game = preload("res://Scenes/Game.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()
	
