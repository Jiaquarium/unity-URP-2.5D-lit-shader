# URP 2.5D Lit Sprite Shader

## Unity Versions / Package Versions
URP 10.2.2

Unity 2020.2.1

## What?
Using bgolus' solution [here](https://forum.unity.com/threads/problem-solving-2d-billboard-sprites-clipping-into-3d-environment.680374/), this shader is based on [Unity's 2019.3release Lit.shader](https://github.com/Unity-Technologies/Graphics/blob/release2019.3/com.unity.render-pipelines.universal/Shaders/Lit.shader).

The shader gives 2D Sprites a Lit behavior (Unity 2020.2.1 doesn't have a built-in Lit 2D shader in 3D environments) and rewrites their clip space depth as if the sprite were vertical<sup>[1](#myfootnote1)</sup> so it won't clip into 3D elements when using a skewed orthographic camera.

<a name="myfootnote1">1</a>: Based on a nearly vertical plane at the sprite's origin.