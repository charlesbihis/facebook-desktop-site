package com.facebookdesktop.components
{
import flash.geom.Matrix;

import mx.skins.ProgrammaticSkin;

public class GradientBackground extends ProgrammaticSkin
{
override public function get measuredWidth():Number
{
return 20;
}

override public function get measuredHeight():Number
{
return 20;
}

override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
{
var fillColors:Array = getStyle("fillColors");
var fillAlphas:Array = getStyle("fillAlphas");
var gradientType:String = getStyle("gradientType");
var cornerRadii:Array = getStyle("cornerRadii");
var angle:Number = getStyle("angle");
var focalPointRatio:Number = getStyle("focalPointRatio");

// Default values, if styles aren’t defined
if (fillColors == null)
fillColors = [0xEEEEEE, 0x999999];

if (fillAlphas == null)
fillAlphas = [1, 1];

if (gradientType == "" || gradientType == null)
gradientType = "linear";

if (isNaN(angle))
angle = 90;

if (isNaN(focalPointRatio))
focalPointRatio = 0.5;

if (cornerRadii == null)
cornerRadii = [5, 5, 5, 5];

var matrix:Matrix = new Matrix();
matrix.createGradientBox(unscaledWidth, unscaledHeight, angle * Math.PI / 180);

graphics.beginGradientFill(gradientType, fillColors, fillAlphas, [0, 255] , matrix, "pad", "rgb", focalPointRatio);
//graphics.drawRoundRect(0, 0, unscaledWidth, unscaledHeight, 0.55, 0.55);
graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, cornerRadii[0], cornerRadii[1], cornerRadii[2], cornerRadii[3]);
graphics.endFill();
}
}
}