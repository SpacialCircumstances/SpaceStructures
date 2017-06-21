uniform sampler2D tex;

static float2 texCoord;
static float4 color;
static float4 gl_FragColor;

struct InputFrag
{
    float4 color : TEXCOORD0;
    float2 texCoord : TEXCOORD1;
};

struct OutputFrag
{
    float4 gl_FragColor : COLOR;
};

void frag_main()
{
    float4 texcolor = tex2D(tex, texCoord) * color;
    float3 _32 = texcolor.xyz * color.w;
    texcolor = float4(_32.x, _32.y, _32.z, texcolor.w);
    gl_FragColor = texcolor;
}

OutputFrag main(InputFrag input)
{
    texCoord = input.texCoord;
    color = input.color;
    frag_main();
    OutputFrag output;
    output.gl_FragColor = gl_FragColor;
    return output;
}
