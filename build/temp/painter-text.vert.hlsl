uniform float4x4 projectionMatrix;

static float4 gl_Position;
static float3 vertexPosition;
static float2 texCoord;
static float2 texPosition;
static float4 fragmentColor;
static float4 vertexColor;

struct InputVert
{
    float2 texPosition : TEXCOORD0;
    float4 vertexColor : TEXCOORD1;
    float3 vertexPosition : TEXCOORD2;
};

struct OutputVert
{
    float4 fragmentColor : TEXCOORD0;
    float2 texCoord : TEXCOORD1;
    float4 gl_Position : SV_POSITION;
};

void vert_main()
{
    gl_Position = mul(float4(vertexPosition, 1.0f), projectionMatrix);
    texCoord = texPosition;
    fragmentColor = vertexColor;
}

OutputVert main(InputVert input)
{
    vertexPosition = input.vertexPosition;
    texPosition = input.texPosition;
    vertexColor = input.vertexColor;
    vert_main();
    OutputVert output;
    output.gl_Position = gl_Position;
    output.texCoord = texCoord;
    output.fragmentColor = fragmentColor;
    output.gl_Position.z = (output.gl_Position.z + output.gl_Position.w) * 0.5;
    return output;
}
