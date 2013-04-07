window.JST = {};
JST['story'] = function anonymous(locals, attrs, escape, rethrow, merge) {
attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
var buf = [];
with (locals || {}) {
var interp;
buf.push('<div class="article-title"><h1>The Rising Influence of China</h1><p class="credit">By Mike McDonough<span class="date">');
var __val__ = ' March 31, 2013 | 3:23PM ET'
buf.push(escape(null == __val__ ? "" : __val__));
buf.push('</span></p></div><div class="content"><div class="sidebar"><div class="chapters"></div><img src="images/arrows.png" class="arrows"/><a href="#" class="prev">Previous</a><a href="#" class="next">Next</a></div><div class="illustration"><div id="vis"></div><div class="extended-content"><p></p></div></div></div>');
}
return buf.join("");
};
