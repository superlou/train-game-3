@tool
class_name Platform
extends Node2D


signal platform_entered
signal platform_exited


func _ready():
    $PlatformArea.connect("body_entered", _on_platform_area_body_entered)
    $PlatformArea.connect("body_exited", _on_platform_area_body_exited)


func _on_platform_area_body_entered(body:Node2D):
    platform_entered.emit(body)
    

func _on_platform_area_body_exited(body:Node2D):
    platform_exited.emit(body)


func contains(body:Node2D):
    return $PlatformArea.overlaps_body(body)
    