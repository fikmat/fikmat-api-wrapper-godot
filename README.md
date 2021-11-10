# Fikmat
Simple Godot wrapper for [Fikmat API](https://github.com/fikmatt/fikmat-api)
It deals with request sending automatically, you just update the data and they will be processed with next request in queue.

### How to use
- create a empty Node scene, attach the script and save it as `FikmatApi`
- set the node to autoload as singleton  
https://docs.godotengine.org/en/stable/getting_started/step_by_step/singletons_autoload.html
- then you can use `FikApi.set_data` function from any script in your project
- function accepts `Dictionary` as argument  
https://docs.godotengine.org/en/stable/classes/class_dictionary.html

### Examples
```
# led strips
var colors = [[255, 0, 0], [0, 255, 0], [0, 0, 255]]
FikApi.set_data({ "led_right": colors, "led_left": colors })

# vibrations
FikApi.set_data({ "vibrate": 99 })

```
