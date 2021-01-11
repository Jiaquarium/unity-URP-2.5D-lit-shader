# URP 2.5D Lit Sprite Shader

## Unity Versions / Package Versions
URP 10.2.2

Unity 2020.2.1

## What?
Using bgolus' solution [here](https://forum.unity.com/threads/problem-solving-2d-billboard-sprites-clipping-into-3d-environment.680374/), this shader is based on [Unity's 2019.3release Lit.shader](https://github.com/Unity-Technologies/Graphics/blob/release2019.3/com.unity.render-pipelines.universal/Shaders/Lit.shader).

The shader gives 2D Sprites a Lit behavior (Unity 2020.2.1 doesn't have a built-in Lit 2D shader in 3D environments) and rewrites their clip space depth as if the sprite were vertical<sup>[1](#myfootnote1)</sup> so it won't clip into 3D elements when using a skewed orthographic camera.

## Please Note
Please note, nondirectional shadows and directional shadows on mobile use world position passed to the fragment shader pass, so you may see sprites receiving shadows as if they were still being clipped with these use cases.

Original discussion can be found [here](https://forum.unity.com/threads/2d-sprites-to-not-be-clipped-by-3d-meshes-and-have-diffused-lit-sprite-shader-look.1034572/#post-6710353).

<a name="myfootnote1">1</a>: Based on a nearly vertical plane at the sprite's origin.