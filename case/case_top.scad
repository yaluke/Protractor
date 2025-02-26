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
        cube([55.5, 30, 2]);
        translate([2.7, 2.2, 0]) cube([52.8, 25.6, 2.5]);
        translate([54.1 , 0, 0]) cube([1.4, 30, 13]);
        //4 top screws
        translate([4.5, 0, 0]) cylinder(2, 4.5, 4.5);
        translate([49.5, 0, 0]) cylinder(2, 4.5, 4.5);
        translate([4.5, 30, 0]) cylinder(2, 4.5, 4.5);
        translate([49.5, 30, 0]) cylinder(2, 4.5, 4.5);
    }
    //4 holes for top screws
    translate([4.5,-1,-0.5]) cylinder(3, 1.2, 1.2);
    translate([49.5,-1,-0.5]) cylinder(3, 1.2, 1.2);
    translate([4.5,31,-0.5]) cylinder(3, 1.2, 1.2);
    translate([49.5,31,-0.5]) cylinder(25, 1.2, 1.2);
    //2 holes for the display
    translate([16, 7.5, 0.5]) cube([31, 15, 3]);
    translate([17, 8.5, -0.5]) cube([29, 13, 4]);
    //hole for button
    translate([8.0, 16.5, -0.5]) cylinder(4, 2, 2);
}
