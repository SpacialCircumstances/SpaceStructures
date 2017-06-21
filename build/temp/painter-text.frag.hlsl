uniform sampler2D tex;

static float4 gl_FragColor;
static float4 fragmentColor;
static float2 texCoord;

struct InputFrag
{
    float4 fragmentColor : TEXCOORD0;
    float2 texCoord : TEXCOORD1;
};

struct OutputFrag
{
    float4 gl_FragColor : COLOR;
};

void frag_main()
{
    gl_FragColor = float4(fragmentColor.xyz, tex2D(tex, texCoord).x * fragmentColor.w);
}

OutputFrag main(InputFrag input)
{
    fragmentColor = input.fragmentColor;
    texCoord = input.texCoord;
    frag_main();
    OutputFrag output;
    output.gl_FragColor = gl_FragColor;
    return output;
}
