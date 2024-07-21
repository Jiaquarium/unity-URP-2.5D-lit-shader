# Universal RP 2.5D Lit Sprite Shader 🖤 &middot; [![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fluo-boa%2Funity-URP-2.5D-lit-shader&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

An implementation of this shader is used in [Night Loops](https://store.steampowered.com/app/1826060/Night_Loops/) (If you'd like to support, please consider picking up a copy. Thank you!!)

The shader prevents 2D Sprites from clipping horribly into the 3D environment when using a skewed orthographic camera. This is useful for setups where 2D sprites must be rotated towards the camera in a 3D environment to achieve a 2.5D look and feel. Also gives 2D Sprites a Lit Behavior when using Unity's Universal RP 3D settings.

![Shader Demo Pic](/Assets/demo_0.jpg)

* helps prevent rotated Sprites from clipping nearby 3D meshes by rewriting the clip space depth as if the Sprite were vertically aligned in the world like the meshes are
* allows Sprites to react to lighting and receive / cast realtime shadows from Directional Lights

***
#### Before and After Comparison of Using Sprites Near 3D Meshes
![Comparison](/Assets/demo_1.png)
> "Feels good to not have my head inside these cabinets all day."

## Requirements
* URP 10.2.1+
* Unity 2020.2.1

> For older versions see branches (e.g. 2019.3)

## Extra Utils

__Camera Offset Ray Start__ adjusts the ray starting position used for calculating the ray plane intersection. You can match these values with your orthographic camera's skew to "tilt" the plane the sprite is on. Useful for keeping large sprites from clipping when very close to a north wall.

Other shaders for special cases can be found on the __production__ branch, which contains the actual shaders used in-game.

## Things to Keep in Mind

* nondirectional shadows and directional shadows on mobile use world position passed to the fragment shader pass, so you may see sprites receiving shadows as if they were still being clipped with these use cases
* this renders the Sprite as an opaque object, so sorting order will be ignored
* in Unity, you may need to also set the Sprite Renderer component's properties `Cast Shadows = On` and `Receive Shadows = True` (which are available in Debug mode only)
* in [LitForwardPass.hlsl](https://github.com/strawberryjamnbutter/unity-URP-2.5D-lit-shader/blob/main/LitForwardPass.hlsl), in the vertex shader, the clip space depth is overwritten

## References

* bgolus' shader-only solution for 2D sprites clipping into 3D meshes [here](https://forum.unity.com/threads/problem-solving-2d-billboard-sprites-clipping-into-3d-environment.680374/)
* [Unity's Graphics repo](https://github.com/Unity-Technologies/Graphics/tree/master)
* original discussion can be found [here](https://forum.unity.com/threads/2d-sprites-to-not-be-clipped-by-3d-meshes-and-have-diffused-lit-sprite-shader-look.1034572/#post-6710353)
