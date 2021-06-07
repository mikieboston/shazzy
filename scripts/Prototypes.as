/**
   September 2007
   Slideshow 6 - XML

   Copyright © 2007 by Andrei Potorac
   All rights reserved.
*/
Array.prototype.randoMix = function(rdm) {
	if (this.length<1) {
		if (rdm == null || rdm<0) {
			rdm = 10;
		}
		for (c=0; c<rdm; c++) {
			this[c] = c+1;
		}
	}
	rdm = this.length;
	for (i=0; i<rdm; i++) {
		rdMix = random(rdm);
		this.temp = this[rdMix];
		this.push(this.temp);
		this.splice(rdMix, 1);
		rdm--;
	}
};
// ----------
// Examples.
// ----------
/*

arr2 = new Array();
arr2.randoMix();
trace(arr2);

arr1 = new Array("one", "two", "three", "four", "five");
arr1.randoMix();
trace(arr1);


arr3 = new Array();
arr3.randoMix(20);
trace(arr3);
*/
//
//************************************************************//
//  ELASTIC EFFECT
//************************************************************//
MovieClip.prototype.elastic = function(prop:Array, speed:Number, rem:Boolean, f:String):Void  {
	this.onEnterFrame = function():Void  {
		for (i in prop) {
			if (this[i] != prop[i]) {
				if (speed == 0) {
					this[i] = prop[i];
				} else {
					this[i] += (prop[i]-this[i])/speed;
				}
			}
			if (Math.abs(this[i]-prop[i])<1) {
				delete this.onEnterFrame;
				if (_root.effect == "scroll") {
					_root.maskDone = true;
				}
				if (rem) {
					this.removeMovieClip();
				}
				for (i in prop) {
					this[i] = prop[i];
				}
				if (f) {
					eval(f);
				}
			}
		}
	};
};
//_root.imageControl["image"+id].elastic({_y:0}, 10, _root.flash());
//************************************************************//
// SQUARE
//************************************************************//
MovieClip.prototype.square = function(x, y, w, h, col) {
	if (col == undefined) {
		col = 0x000000;
	}
	this.beginFill(col, 100);
	this.moveTo(x, y);
	this.lineTo(x+w, y);
	this.lineTo(x+w, y+h);
	this.lineTo(x, y+h);
	this.lineTo(x, y);
	this.endFill();
};
MovieClip.prototype.outline = function(x, y, w, h, col) {
	this.square(0, 0, w, 1, col);
	this.square(w-1, 1, 1, h-2, col);
	this.square(0, h-1, w, 1, col);
	this.square(0, 1, 1, h-2, col);
};
//************************************************************//
// CHANGE THE COLOR OF A MOVIECLIP
//************************************************************//
MovieClip.prototype.setColor = function(col:String):Void  {
	this.mycol = new Color(this);
	this.mycol.setRGB(col);
};
//************************************************************//
//  EFFECT: "FADE IN" AND "FADE OUT" IMAGES
//************************************************************//
MovieClip.prototype.fade = function(dir:String, addInteger:Number):Void  {
	this.step = (dir == "in") ? 0 : 100;
	this.onEnterFrame = function():Void  {
		this.step = (dir == "in") ? this.step+addInteger : this.step-addInteger;
		this._alpha = this.step;
		if (((dir == "in") && this._alpha>=100) || ((dir == "out") && this._alpha<=0)) {
			delete this.onEnterFrame;
		}
	};
};
