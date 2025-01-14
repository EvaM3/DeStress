//
//  MetalShader.metal
//  DeStress
//
//  Created by Eva Sira Madarasz on 03/07/2024.
//



#include <metal_stdlib>

using namespace metal;

struct VertexIn {
    float4 position [[attribute(0)]];
};

fragment float4 fragment_shader() {
    return float4(0.0, 1.0, 0.0, 1.0); // Example: Green color
}


