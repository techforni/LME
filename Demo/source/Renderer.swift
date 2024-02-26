import Metal
import MetalKit
import simd

class Renderer: NSObject, MTKViewDelegate {

    private var device: MTLDevice!
    private var commandQueue: MTLCommandQueue!
    
    init?(metalKitView: MTKView)
    {
        super.init()
        self.device = metalKitView.device
        self.commandQueue = device.makeCommandQueue()
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
