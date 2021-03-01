# Universal RP 2.5D Lit Sprite Shader 🖤 &middot; [![HitCount](http://hits.dwyl.com/strawberryjamnbutter/unity-URP-25D-lit-shader.svg)](http://hits.dwyl.com/strawberryjamnbutter/unity-URP-25D-lit-shader)

The shader prevents 2D Sprites from clipping horribly into the 3D environment when using a skewed orthographic camera. This is useful for setups where 2D sprites must be rotated towards the camera in a 3D environment to achieve a 2.5D look and feeeel.

![Shader Demo Pic](/Assets/demo_0.png)

Additionally, it gives 2D Sprites a Lit behavior (reacts to Directional Lighting, receives shadows and casts shadows) in a 3D environment when using Unity's Universal RP which does not have a built-in Lit 2D shader in 3D environments.

In [LitForwardPass.hlsl](https://github.com/strawberryjamnbutter/unity-URP-2.5D-lit-shader/blob/main/LitForwardPass.hlsl), in the vertex shader, the clip space depth is overwritten as if the sprite were vertical.

***
#### Before and After Comparison of Using Sprites Near 3D Meshes
![Comparison](/Assets/demo_1.png)
> "Feels good to not have my head inside these cabinets all day."

## Requirements
* URP 10.2.1+
* Unity 2020.2.1

> For older versions see branches (e.g. 2019.3)

## Things to Keep in Mind

* nondirectional shadows and directional shadows on mobile use world position passed to the fragment shader pass, so you may see sprites receiving shadows as if they were still being clipped with these use cases
* this renders the Sprite as an opaque object, so sorting order will be ignored


## References

* bgolus' shader-only solution for 2D sprites clipping into 3D meshes [here](https://forum.unity.com/threads/problem-solving-2d-billboard-sprites-clipping-into-3d-environment.680374/)
* [Unity's Graphics repo](https://github.com/Unity-Technologies/Graphics/tree/master)
* original discussion can be found [here](https://forum.unity.com/threads/2d-sprites-to-not-be-clipped-by-3d-meshes-and-have-diffused-lit-sprite-shader-look.1034572/#post-6710353)