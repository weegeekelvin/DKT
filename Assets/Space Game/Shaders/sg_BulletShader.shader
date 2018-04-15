// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Space Game/Bullet Shader"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTexture("Main Texture", 2D) = "white" {}
		_StartColor("Start Color", Color) = (0,1,0,1)
		_EndColor("End Color", Color) = (0.728,1,0,0)
		_SpreadStart("Spread Start", Float) = 1
		_SpreadEnd("Spread End", Float) = -1
		_Vector1("Vector 1", Vector) = (0,0,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			fixed2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _MainTexture;
		uniform fixed4 _StartColor;
		uniform fixed4 _EndColor;
		uniform fixed _SpreadStart;
		uniform fixed _SpreadEnd;
		uniform fixed3 _Vector1;
		uniform float _Cutoff = 0.5;

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TexCoord60 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float mulTime53 = _Time.y * 1;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 break74 = ( ase_vertex3Pos * _Vector1 );
			float lerpResult52 = lerp( _SpreadStart , _SpreadEnd , ( ( break74.x + break74.y + break74.z ) / 3 ));
			float4 lerpResult46 = lerp( _StartColor , _EndColor , lerpResult52);
			float4 temp_output_44_0 = ( tex2D( _MainTexture, ( uv_TexCoord60 + ( mulTime53 * fixed2( 0.5,0 ) ) ) ) * lerpResult46 );
			o.Emission = temp_output_44_0.rgb;
			o.Alpha = 1;
			clip( temp_output_44_0.a - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15101
-1913;30;1906;1004;1868.983;876.5883;1.3;True;True
Node;AmplifyShaderEditor.Vector3Node;69;-2080,-96;Float;False;Property;_Vector1;Vector 1;6;0;Create;True;0;0;False;0;0,0,1;0,0,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;45;-2080,-240;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-1840,-112;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;74;-1696,-112;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector2Node;59;-1769.928,-295.9428;Float;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;0.5,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;53;-1871.892,-420.9664;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;73;-1456,-112;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;75;-1280,256;Float;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1280,96;Fixed;False;Property;_SpreadStart;Spread Start;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;60;-1756.926,-567.6425;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-1542.425,-315.4428;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1280,176;Fixed;False;Property;_SpreadEnd;Spread End;5;0;Create;True;0;0;False;0;-1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;52;-1056,160;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;-1417.624,-476.6425;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;40;-1280,-256;Fixed;False;Property;_StartColor;Start Color;2;0;Create;True;0;0;False;0;0,1,0,1;0,1,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;41;-1280,-80;Fixed;False;Property;_EndColor;End Color;3;0;Create;True;0;0;False;0;0.728,1,0,0;0.728,1,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;46;-864,-64;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;43;-1280,-464;Float;True;Property;_MainTexture;Main Texture;1;0;Create;True;0;0;False;0;4d91c67cdfbb3ef43931f907d3df64d3;4d91c67cdfbb3ef43931f907d3df64d3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-672,-464;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;49;-432,-368;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-160,-512;Fixed;False;True;2;Fixed;ASEMaterialInspector;0;0;Unlit;Space Game/Bullet Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;0;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;10;1,1,1,1;VertexScale;True;False;Spherical;False;Relative;0;;0;-1;-1;0;0;0;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;68;0;45;0
WireConnection;68;1;69;0
WireConnection;74;0;68;0
WireConnection;73;0;74;0
WireConnection;73;1;74;1
WireConnection;73;2;74;2
WireConnection;75;0;73;0
WireConnection;62;0;53;0
WireConnection;62;1;59;0
WireConnection;52;0;50;0
WireConnection;52;1;51;0
WireConnection;52;2;75;0
WireConnection;61;0;60;0
WireConnection;61;1;62;0
WireConnection;46;0;40;0
WireConnection;46;1;41;0
WireConnection;46;2;52;0
WireConnection;43;1;61;0
WireConnection;44;0;43;0
WireConnection;44;1;46;0
WireConnection;49;0;44;0
WireConnection;0;2;44;0
WireConnection;0;10;49;3
ASEEND*/
//CHKSM=27382080B33A4F5144EF225DB3CB883B540EAE2B