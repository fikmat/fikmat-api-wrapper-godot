extends Node

const API_URL = "http://localhost:8020/api"
const FREQUENCY = 1.0/30 # max 30 requests per second

var current_data := {}
var dirty := false
var waiting_for_response := false

onready var http_request := HTTPRequest.new()
onready var timer := Timer.new()

func _ready():
  http_request.connect("request_completed", self, "_on_request_completed")
  add_child(http_request)

  timer.set_wait_time(FREQUENCY)
  timer.set_one_shot(false)
  timer.connect("timeout", self, "_update") 
  add_child(timer)
  timer.start()


func _update() -> void:
  if dirty && !waiting_for_response:
    _send_post_request(current_data)
    dirty = false
    current_data = {}


func _send_post_request(data_to_send: Dictionary) -> void:
  var query := JSON.print(data_to_send)
  var headers := ["Content-Type: application/json"]
  http_request.request(API_URL, headers, false, HTTPClient.METHOD_POST, query)
  waiting_for_response = true


func _on_request_completed(_result, _response_code, _headers, _body) -> void:
  print(_response_code)
  waiting_for_response = false


func set_data(data: Dictionary) -> void:
  for key in data:
      current_data[key] = data[key]
  dirty = true
