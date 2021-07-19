// Updated for URP 10.2.1/release
// Used by SpritesLit and SpritesUnlitShadow.
// https://github.com/Unity-Technologies/Graphics/blob/10.2.1/release/com.unity.render-pipelines.universal/Shaders/ShadowCasterPass.hlsl

#ifndef UNIVERSAL_SHADOW_CASTER_PASS_INCLUDED
#define UNIVERSAL_SHADOW_CASTER_PASS_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"

float3 _LightDirection;

struct Attributes
{
    float4 positionOS   : POSITION;
    float3 normalOS     : NORMAL;
    float2 texcoord     : TEXCOORD0;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct Varyings
{
    float2 uv           : TEXCOORD0;
    float4 positionCS   : SV_POSITION;
};

// Rotating a vertex by Quaternion
// https://www.geeks3d.com/20141201/how-to-rotate-a-vertex-by-a-quaternion-in-glsl/
float4 QuatFromAxisAngle(float3 axis, float angle)
{ 
  float4 qr;
  float halfAngle = (angle * 0.5) * PI / 180.0;
  qr.x = axis.x * sin(halfAngle);
  qr.y = axis.y * sin(halfAngle);
  qr.z = axis.z * sin(halfAngle);
  qr.w = cos(halfAngle);
  return qr;
}

float3 RotateVertexQuaternion(float3 position, float3 axis, float angle)
{ 
  float4 q = QuatFromAxisAngle(axis, angle);
  float3 v = position.xyz;
  return v + 2.0 * cross(q.xyz, cross(q.xyz, v) + q.w * v);
}

float4 GetShadowPositionHClip(Attributes input)
{
    // Skew transformation matrix
    float h = _ShadowHorizontalSkew;
    float v = _ShadowVerticalSkew;

    float x = _ShadowTranslation.x;
    float y = _ShadowTranslation.y;
    float z = _ShadowTranslation.z;

    float a = _ShadowScale.x;
    float b = _ShadowScale.y;
    float c = _ShadowScale.z;
    
    float4x4 transformMatrix = float4x4(
        a, h, 0, x,
        v, b, 0, y,
        0, 0, c, z,
        0, 0, 0, 1
    );

    // Quarternion rotation
    float3 P = RotateVertexQuaternion(input.positionOS.xyz, _ShadowRotation.xyz, _ShadowRotation.w);
    input.positionOS = float4(P.x, P.y, P.z, 1);

    // Transform with matrix
    float4 transformedPositionOS = mul(transformMatrix, input.positionOS);

    // Apply URP Shadow Bias
    float3 positionWS = TransformObjectToWorld(transformedPositionOS.xyz);
    float3 normalWS = TransformObjectToWorldNormal(input.normalOS);
    float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, _LightDirection));

#if UNITY_REVERSED_Z
    positionCS.z = min(positionCS.z, positionCS.w * UNITY_NEAR_CLIP_VALUE);
#else
    positionCS.z = max(positionCS.z, positionCS.w * UNITY_NEAR_CLIP_VALUE);
#endif

    return positionCS;
}

Varyings ShadowPassVertex(Attributes input)
{
    Varyings output;
    UNITY_SETUP_INSTANCE_ID(input);

    output.uv = TRANSFORM_TEX(input.texcoord, _MainTex);
    output.positionCS = GetShadowPositionHClip(input);
    
    return output;
}

half4 ShadowPassFragment(Varyings input) : SV_TARGET
{
    Alpha(SampleAlbedoAlpha(input.uv, TEXTURE2D_ARGS(_MainTex, sampler_MainTex)).a, _BaseColor, _Cutoff);
    return 0;
}

#endif