import Foundation
import Metal

public class RenderPipeline : NSObject
{
    private var renderPipelineState: MTLRenderPipelineState!
    private var PipelineshaderLibrary: MTLLibrary!
    
    
    public init(_ device: MTLDevice, _ shaderFunc: [String])
    {
        // MSL Loader
        do
        {
            self.PipelineshaderLibrary = try device.makeLibrary(URL: Bundle.main.url(forResource: "ShaderKit", withExtension: "metallib")!)
        } catch let error {
            print("[ERROR]  \(error)")
        }
        
        var rpDescritptor = MTLRenderPipelineDescriptor()
        
        rpDescritptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        rpDescritptor.vertexFunction = self.PipelineshaderLibrary.makeFunction(name: shaderFunc[0])
        rpDescritptor.fragmentFunction = self.PipelineshaderLibrary.makeFunction(name: shaderFunc[1])
        
        do {
            self.renderPipelineState = try device.makeRenderPipelineState(descriptor: rpDescritptor)
        } catch let error {
            print("[ERROR]  \(error)")
        }
    }
    
    public func bindToEncoder(_ encoder: MTLRenderCommandEncoder) -> Void
    {
        encoder.setRenderPipelineState(self.renderPipelineState)
    }
    
    public func getInstance() -> MTLRenderPipelineState
    {
        return self.renderPipelineState
    }
}
