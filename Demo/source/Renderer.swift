import Metal
import MetalKit
import simd

import LMERenderAPI

class Renderer: NSObject, MTKViewDelegate {

    private var device: MTLDevice!
    private var commandQueue: MTLCommandQueue!
    
    private var testBUffer: VertexBuffer!
    
    init?(metalKitView: MTKView)
    {
        super.init()
        self.device = metalKitView.device
        self.commandQueue = device.makeCommandQueue()
        
        self.testBUffer = VertexBuffer(self.device, [
            Vertex(pos: simd_float3(0.0, 1.0, 2.0), color: simd_float4(0.0, 0.0, 0.0, 0.0))
        ])
        
    }

    func draw(in view: MTKView)
    {
        guard let commandBuffer = commandQueue.makeCommandBuffer() else { return }
        guard let renderPass = view.currentRenderPassDescriptor else { return }
        
        renderPass.colorAttachments[0].storeAction = .store
        renderPass.colorAttachments[0].loadAction = .clear
        renderPass.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1.0)
        
        guard let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPass) else { return }
        renderEncoder.endEncoding()
        
        commandBuffer.present(view.currentDrawable!)
        commandBuffer.commit()
        
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize)
    {
        
    }
}
