# PRC Android 2D game engine
2018-2020

[Source Code](https://github.com/chomosuke/PRCAndroid2DGameEngine)

## Summary
A 2D mini game engine for Android based on OpenGL ES.

## Description
- While working on [Project Rocket](./project-rocket.md) I needed to display various shape on the screen moving around smoothly.
- I didn't know game engine existed at the time, so I followed the OpenGL section of Android's [official developer guide](https://developer.android.com/guide) (I can no longer find the specific page I followed).
- I ended up making a mini custom game engine for Project Rocket which I later refactored into a standalone mini game engine.
- While I can not say this game engine have any advantage over any real game engines, it does provide most of the functionality needed to create an Android 2D game including:
	- Drawing texture.
	- Drawing basic geometric shapes such as triangle, ellipse, polygon etc.
	- Performant collision detections.
	- Multithreading utilities.
