//
// The MIT License (MIT)
//
// Copyright (c) 2025 Lukasz Ronka
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
 
$fa=1;
$fs=0.1;
difference(){
    union() {
        //base
        cube([55.5, 30, 31.5]);
        //2 handlers
        translate([55.5/2, 0, 0]) cylinder(5, 15, 15);
        translate([55.5/2, 30, 0]) cylinder(5, 15, 15);
        //4 top screws
        translate([4.5, 0, 0]) cylinder(31.5, 4.5, 4.5);
        translate([49.5, 0, 0]) cylinder(31.5, 4.5, 4.5);
        translate([4.5, 30, 0]) cylinder(31.5, 4.5, 4.5);
        translate([49.5, 30, 0]) cylinder(31.5, 4.5, 4.5);
    }
    //bottom of the box
    translate([2, 4, 2]) cube([52, 22, 30]);
    //top part of the box
    translate([2, 2, 20]) cube([52, 26, 25]);
    //2 holes in handlers 
    translate([55.5/2, 38, -1]) cylinder(7, 3.5, 3.5);
    translate([55.5/2, -8, -1]) cylinder(7, 3.5, 3.5);
    //4 holes for top screws
    translate([4.5,-1,7]) cylinder(25, 1.3, 1.3);
    translate([49.5,-1,7]) cylinder(25, 1.3, 1.3);
    translate([4.5,31,7]) cylinder(25, 1.3, 1.3);
    translate([49.5,31,7]) cylinder(25, 1.3, 1.3);
    //4 holes for nuts
    translate([4.5,-1,29.3]) cylinder(3, 2.4, 2.5, $fa=60);
    translate([49.5,-1,29.3]) cylinder(3, 2.4, 2.5, $fa=60);
    translate([4.5,31,29.3]) cylinder(3, 2.4, 2.5, $fa=60);
    translate([49.5,31,29.3]) cylinder(3, 2.4, 2.5, $fa=60);
    //hole for usb plug
    translate([53.5,10.5,5.5]) cube([2.5, 9, 27]);
    //hole for encoder plug
    translate([53.99,-1,10.5]) cube([2.5, 32, 22]);

}
