import Foundation
import Metal
import simd

/// Defintion for a single vertex
public struct Vertex
{
    public var pos: simd_float3
    public var color: simd_float4
    
    public init(pos: simd_float3, color: simd_float4) {
        self.pos = pos
        self.color = color
    }
}

public class VertexBuffer : NSObject
{
    private var bufferInstance: MTLBuffer!
    
    public init(_ device: MTLDevice, _ vertexData: [Vertex])
    {
        guard let _vertexBuffer = device.makeBuffer(bytes: vertexData, length: vertexData.count * MemoryLayout<Vertex>.stride(ofValue: vertexData[0]), options: .storageModeShared) else
        {
            print("Uanble to create a valid vertex buffer!")
            return
        }
        self.bufferInstance = _vertexBuffer
    }
    
    public func bindToEncoder(_ renderEncoder: MTLRenderCommandEncoder) -> Void
    {
        renderEncoder.setVertexBuffer(self.bufferInstance, offset: 0, index: 0)
    }
    
    public func getInstance() -> MTLBuffer!
    {
        return self.bufferInstance
    }
}
