static float4 gl_FragColor;
static float4 fragmentColor;

struct InputFrag
{
    float4 fragmentColor : TEXCOORD0;
};

struct OutputFrag
{
    float4 gl_FragColor : COLOR;
};

void frag_main()
{
    gl_FragColor = fragmentColor;
}

OutputFrag main(InputFrag input)
{
    fragmentColor = input.fragmentColor;
    frag_main();
    OutputFrag output;
    output.gl_FragColor = gl_FragColor;
    return output;
}
