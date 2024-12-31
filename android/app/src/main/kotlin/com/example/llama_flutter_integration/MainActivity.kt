import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "ai_assistant_channel"
    private lateinit var llamaInterface: LlamaInterface

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        llamaInterface = LlamaInterface()
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "initModel" -> {
                    val success = llamaInterface.initModel()
                    result.success(success)
                }
                "generateResponse" -> {
                    val prompt = call.argument<String>("prompt")
                    if (prompt != null) {
                        val response = llamaInterface.generateResponse(prompt)
                        result.success(response)
                    } else {
                        result.error("INVALID_ARGUMENT", "Prompt cannot be null", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
