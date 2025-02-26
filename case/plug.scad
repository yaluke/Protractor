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
    union(){
        cube([40, 15.3, 4.7]);
        translate([17, 2, 3.7]) cube([16, 1, 2]);
        
        translate([1.5, -1, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([3, -1, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([4.5, -1, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([6, -1, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([7.5, -1, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([9, -1, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([10.5, -1, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);

        translate([1.5, 13.3, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([3, 13.3, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([4.5, 13.3, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([6, 13.3, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([7.5, 13.3, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([9, 13.3, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);
        translate([10.5, 13.3, 0]) rotate([0, 0, 45]) cube([2, 2, 4.7]);

    }
    translate([9.99, 15.3/2, 4.7]) rotate([0, 90, 0]) cylinder(50, 3, 3);
    translate([-1, 2, 2]) cube([11, 11.3, 5.4]);
    //4 holes for nuts
    translate([13, 3, -1]) cylinder(3, 2.5, 2.4, $fa=60);
    translate([13, 12.3, -1]) cylinder(3, 2.5, 2.4, $fa=60);
    translate([36.5, 3, -1]) cylinder(3, 2.5, 2.4, $fa=60);
    translate([36.5, 12.3, -1]) cylinder(3, 2.5, 2.4, $fa=60);
    
    translate([13,3,-1]) cylinder(25, 1.3, 1.3);
    translate([13,12.3,-1]) cylinder(25, 1.3, 1.3);
    translate([36.5,3,-1]) cylinder(25, 1.3, 1.3);
    translate([36.5,12.3,-1]) cylinder(25, 1.3, 1.3);

    translate([16.75, 12.05, 3.45]) cube([16.5, 1.5, 2]);

}