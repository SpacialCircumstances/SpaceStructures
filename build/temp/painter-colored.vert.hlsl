uniform float4 gl_HalfPixel;
uniform float4x4 projectionMatrix;

static float4 gl_Position;
static float3 vertexPosition;
static float4 fragmentColor;
static float4 vertexColor;

struct InputVert
{
    float4 vertexColor : TEXCOORD0;
    float3 vertexPosition : TEXCOORD1;
};

struct OutputVert
{
    float4 fragmentColor : TEXCOORD0;
    float4 gl_Position : POSITION;
};

void vert_main()
{
    gl_Position = mul(float4(vertexPosition, 1.0f), projectionMatrix);
    fragmentColor = vertexColor;
}

OutputVert main(InputVert input)
{
    vertexPosition = input.vertexPosition;
    vertexColor = input.vertexColor;
    vert_main();
    OutputVert output;
    output.gl_Position = gl_Position;
    output.fragmentColor = fragmentColor;
    output.gl_Position.x = output.gl_Position.x - gl_HalfPixel.x * output.gl_Position.w;
    output.gl_Position.y = output.gl_Position.y + gl_HalfPixel.y * output.gl_Position.w;
    output.gl_Position.z = (output.gl_Position.z + output.gl_Position.w) * 0.5;
    return output;
}
