(function(){var t=this;(function(){(function(){this.XCard={VERSION:"0.0.1",config:{maxCellsPerRow:12,classPrefix:"xcard"}}}).call(this)}).call(t);var o=t.XCard;(function(){(function(){o.extend=function(t){var o,e;for(o in t)e=t[o],this[o]=e;return this}}).call(this),function(){o.extend({elementToString:function(t,e){var n;return null==e&&(e={}),n=o.makeElement(t,e),n.outerHTML},makeElement:function(t,o){var e,n,s,i,l,r,c,u,a,h;if(null==o&&(o={}),n=document.createElement(t),o.attributes){r=o.attributes;for(i in r)h=r[i],n.setAttribute(i,h)}if(o.style){c=o.style;for(i in c)h=c[i],n.style[i]=h}if(o.data){u=o.data;for(i in u)h=u[i],n.dataset[i]=h}if(o.className)for(a=o.className.split(" "),s=0,l=a.length;l>s;s++)e=a[s],n.classList.add(e);return o.textContent&&(n.textContent=o.textContent),o.colSpan&&n.setAttribute("colspan",o.colSpan),n}})}.call(this),function(){o.chunkArray=function(t,o){var e,n,s;if(0===t.length||1===o)return t;for(e=[],n=0,s=t.length;s>n;)e.push(t.slice(n,n+=o));return e}}.call(this),function(){o.extend({uniqueArray:function(t){var o,e,n,s;for(n={},e=0,s=t.length;s>e;e++)o=t[e],n[""+o+typeof o]=o;return Object.keys(n).map(function(t){return n[t]})}})}.call(this),function(){}.call(this),function(){o.DistanceBlock=function(){function t(t,e){var n;if(null==t&&(t={}),this.endsScoreData=null!=e?e:{},this.options=Object.assign({element:"tbody",config:null},t),null==this.options.config)throw"Distance configuration is required";this.config=this.options.config,this.totalizer=null!=(n=this.options.totalizer)?n:new o.Totalizer({config:this.config}),this.configureBlock()}return t.prototype.configureBlock=function(){var t,e,n;for(this.numberOfEnds=this.config.totalShots/this.config.shotsPerEnd,this.endsPerRow=this.getEndsPerRow(),this.cellsPerEnd=this.getCellsPerEnd(),this.rowCount=this.numberOfEnds/this.endsPerRow,this.endTotalCells=this.endsPerRow,this.titleCellSpan=this.getTitleCellSpan(),this.chunkedEndsScoreData=o.chunkArray(this.endsScoreData,this.endsPerRow),this.rows=[new o.DistanceHeaderRow({config:this.config,title:this.config.title,titleCellSpan:this.titleCellSpan})],e=t=1,n=this.rowCount;n>=1?n>=t:t>=n;e=n>=1?++t:--t)this.rows.push(new o.ScoringRow({cellCount:this.cellsPerEnd,endCount:this.endsPerRow,config:this.config,totals:this.totalizer},this.chunkedEndsScoreData[e-1]));return this.rows.push(new o.DistanceTotalsRow({config:this.config,totals:this.totalizer,cellSpan:this.titleCellSpan}))},t.prototype.getCellsPerEnd=function(){return this.config.shotsPerEnd<=3?3:this.config.shotsPerEnd<=6?6:12},t.prototype.getEndsPerRow=function(){return this.config.shotsPerEnd<=6?2:1},t.prototype.getTitleCellSpan=function(){return this.endsPerRow*this.cellsPerEnd+this.endTotalCells},t.prototype.toHtml=function(){var t,o,e,n,s;for(t=document.createElement(this.options.element),s=this.rows,o=0,e=s.length;e>o;o++)n=s[o],t.appendChild(n.toHtml());return t},t}()}.call(this),function(){o.BasicElement=function(){function t(t,o){null==t&&(t={}),this.element=null!=o?o:"td",this.attributes={},this.setAttributes(t)}return t.prototype.className=function(t){var e;return e=null!=t?t:this.constructor.name.toLowerCase(),o.config.classPrefix+"-"+e},t.prototype.setAttributes=function(t){return null==t&&(t={}),this.attributes=Object.assign(this.attributes,t)},t.prototype.toHtmlString=function(){return o.elementToString(this.element,this.ensureClassnames(this.attributes))},t.prototype.toHtml=function(){return o.makeElement(this.element,this.ensureClassnames(this.attributes))},t.prototype.ensureClassnames=function(t){var e,n;return null==t&&(t={}),e=null!=t.className?t.className.split(" "):[],n=o.uniqueArray(e).sort(),t.className=n.join(" "),t},t}()}.call(this),function(){o.BasicDistanceRow=function(){function t(t,o){this.shotsPerEnd=t,null==o&&(o={}),this.options=Object.assign({withHits:!0,withGolds:!0,withPoints:!1,withX:!1,goldsDescriptor:"g",hitsDescriptor:"h",xDescriptor:"x"},o),this.buildCells()}return t.prototype.buildCells=function(){var t,e,n,s,i,l,r,c;for(this.cells=[],r=this.getScoringCellsPerRow(),t=this.getEndsPerRow(),c=e=1,s=r/t;s>=1?s>=e:e>=s;c=s>=1?++e:--e){for(l=n=1,i=t;i>=1?i>=n:n>=i;l=i>=1?++n:--n)this.cells.push(new o.ScoreCell);this.cells.push(new o.EndTotalCell)}return this.renderHits()&&this.cells.push(new o.BasicCell({classes:["xcard-hits"]})),this.renderGolds()&&this.cells.push(new o.BasicCell({classes:["xcard-golds"]})),this.renderX()&&this.cells.push(new o.BasicCell({classes:["xcard-x"]})),this.cells.push(new o.BasicCell({classes:["xcard-row-total"]})),this.cells.push(new o.BasicCell({classes:["xcard-round-total"]}))},t.prototype.getCells=function(){return this.cells},t.prototype.getScoringCellsPerRow=function(){return this.shotsPerEnd<=3?6:12},t.prototype.getEndsPerRow=function(){return this.shotsPerEnd<=3?3:this.shotsPerEnd<=6?6:12},t.prototype.goldsDescriptor=function(){return this.options.goldsDescriptor},t.prototype.renderHits=function(){return this.options.withHits},t.prototype.renderGolds=function(){return this.options.withGolds},t.prototype.renderX=function(){return this.options.withX},t}()}.call(this),function(){var t=function(t,o){function n(){this.constructor=t}for(var s in o)e.call(o,s)&&(t[s]=o[s]);return n.prototype=o.prototype,t.prototype=new n,t.__super__=o.prototype,t},e={}.hasOwnProperty;o.BasicCell=function(o){function e(t){null==t&&(t={}),e.__super__.constructor.call(this,t,"td")}return t(e,o),e}(o.BasicElement)}.call(this),function(){o.DistanceConfig=function(){function t(t){null==t&&(t={}),this.options=Object.assign({shotsPerEnd:6,title:"Distance",totalShots:36,withHits:!0,withGolds:!0,goldScore:10,withX:!0,recurveMatch:!1,compoundMatch:!1},t),this.goldScore=this.options.goldScore,this.shotsPerEnd=this.options.shotsPerEnd,this.totalShots=this.options.totalShots,this.title=this.options.title,this.withX=this.options.withX,this.withGolds=this.options.withGolds,this.goldScore=this.options.goldScore,this.withPoints=this.showPoints(),this.withHits=this.showHits()}return t.prototype.showHits=function(){return!(this.options.recurveMatch||this.options.compoundMatch)},t.prototype.showPoints=function(){return this.options.recurveMatch},t}()}.call(this),function(){o.DistanceHeaderRow=function(){function t(t){if(null==t&&(t={}),this.options=Object.assign({config:null,title:"1",titleCellSpan:1},t),null==this.options.config)throw"DistanceHeaderRow requires DistanceConfig";this.cells=[this.getTitleCell(),this.getRowTotalCell()],this.options.config.withPoints&&this.cells.push(this.getRowPointsCell()),this.options.config.withHits&&this.cells.push(this.getRowHitsCell()),this.options.config.withGolds&&this.cells.push(this.getRowGoldsCell()),this.options.config.withX&&this.cells.push(this.getRowXCell()),this.cells.push(this.getRunningTotalCell())}return t.prototype.getTitleCell=function(){var t;return t=new o.BasicCell,t.setAttributes({colSpan:this.options.titleCellSpan,textContent:this.options.title,className:"title-cell"}),t},t.prototype.getEndTotalCell=function(){var t;return t=new o.BasicCell,t.setAttributes({className:"end-total-cell"}),t},t.prototype.getRowGoldsCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:"g",className:"row-golds-cell"}),t},t.prototype.getRowTotalCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:"rt",className:"row-total-cell"}),t},t.prototype.getRowHitsCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:"h",className:"row-hits-cell"}),t},t.prototype.getRowPointsCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:"pt",className:"row-points-cell"}),t},t.prototype.getRowXCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:"x",className:"row-x-cell"}),t},t.prototype.getRunningTotalCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:"tot",className:"running-total-cell"}),t},t.prototype.toHtmlString=function(){return this.toHtml().outerHTML},t.prototype.toHtml=function(){var t,e,n,s,i;for(e=new o.BasicElement({className:"header-row"},"tr").toHtml(),i=this.cells.slice(0),n=0,s=i.length;s>n;n++)t=i[n],e.appendChild(t.toHtml());return e},t}()}.call(this),function(){o.DistanceTotalsRow=function(){function t(t){if(null==t&&(t={}),this.options=Object.assign({config:null,title:"1",cellSpan:1,totals:null},t),null==this.options.config)throw"DistanceTotalsRow requires DistanceConfig";this.cells=[this.getSpacerCell()],this.options.config.withHits&&this.cells.push(this.getRowHitsCell()),this.options.config.withGolds&&this.cells.push(this.getRowGoldsCell()),this.options.config.withX&&this.cells.push(this.getRowXCell()),this.cells.push(this.getRunningTotalCell())}return t.prototype.getSpacerCell=function(){var t;return t=new o.BasicCell,t.setAttributes({colSpan:this.options.cellSpan+1,textContent:""}),t},t.prototype.getEndTotalCell=function(){var t;return t=new o.BasicCell,t.setAttributes({className:"end-total-cell"}),t},t.prototype.getRowGoldsCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:this.options.totals.totalGolds.toString(),className:"total-golds-cell"}),t},t.prototype.getRowTotalCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:"rt",className:"row-total-cell"}),t},t.prototype.getRowHitsCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:this.options.totals.totalHits.toString(),className:"total-hits-cell"}),t},t.prototype.getRowPointsCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:this.options.totals.totalPoints.toString(),className:"total-points-cell"}),t},t.prototype.getRowXCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:this.options.totals.totalX.toString(),className:"total-x-cell"}),t},t.prototype.getRunningTotalCell=function(){var t;return t=new o.BasicCell,t.setAttributes({textContent:this.options.totals.totalScore.toString(),className:"total-score-cell"}),t},t.prototype.toHtmlString=function(){return this.toHtml().outerHTML},t.prototype.toHtml=function(){var t,e,n,s,i;for(e=new o.BasicElement({className:"totals-row"},"tr").toHtml(),i=this.cells.slice(0),n=0,s=i.length;s>n;n++)t=i[n],e.appendChild(t.toHtml());return e},t}()}.call(this),function(){var t=function(t,o){function n(){this.constructor=t}for(var s in o)e.call(o,s)&&(t[s]=o[s]);return n.prototype=o.prototype,t.prototype=new n,t.__super__=o.prototype,t},e={}.hasOwnProperty;o.ScoreCell=function(o){function e(t,o){var n,s;this.scoreData=null!=t?t:{},this.unused=null!=o?o:!1,e.__super__.constructor.call(this),this.scoreValue=null!=this.scoreData.score?parseInt(this.scoreData.score,10):null,this.isX=null!=(n=this.scoreData.isX)?n:!1,this.isGold=null!=(s=this.scoreData.isGold)?s:!1,this.text=this.scoreData.text,this.setAttributes({className:this.getClasses(),textContent:this.getTextContent(),data:{score:this.scoreValue}})}return t(e,o),e.prototype.getClasses=function(){var t;return t=["score-cell"],this.unused&&t.push("unused"),t.join(" ")},e.prototype.getTextContent=function(){return null==this.scoreValue?"":0===this.scoreValue?"m":null!=this.text?this.text:this.scoreValue},e.prototype.score=function(){var t;return null!=(t=this.scoreValue)?t:0},e}(o.BasicCell)}.call(this),function(){o.ScoringEnd=function(){function t(t){if(null==t&&(t={}),this.options=Object.assign({cellCount:3,scores:[],config:null},t),null==this.options.config)throw"ScoringEnd requires DistanceConfig";this.build()}return t.prototype.build=function(){return this.buildScoringCells(),this.buildEndTotalCell()},t.prototype.buildScoringCells=function(){var t,e,n,s,i,l,r;for(this.scoringCells=[],i=[],t=e=1,n=this.options.cellCount;n>=1?n>=e:e>=n;t=n>=1?++e:--e)r=t>this.options.config.shotsPerEnd?!0:!1,l=null!=(s=this.options.scores[t-1])?s:{},i.push(this.scoringCells.push(new o.ScoreCell(l,r)));return i},t.prototype.buildEndTotalCell=function(){return this.endTotalCell=new o.EndTotalCell({config:this.options.config,scoringCells:this.scoringCells})},t.prototype.cells=function(){var t;return t=this.scoringCells.slice(0),t.push(this.endTotalCell),t},t.prototype.hasAtLeastOneScore=function(){return this.scoringCells.filter(function(t){return null!=t.scoreValue}).length>0},t.prototype.totalHits=function(){return this.scoringCells.filter(function(t){return t.score()>0}).length},t.prototype.totalScore=function(){return this.endTotalCell.totalScore()},t}()}.call(this),function(){o.ScoringRow=function(){function t(t,o){if(null==t&&(t={}),this.endScoresData=null!=o?o:[],this.options=Object.assign({cellCount:3,element:"tr",endCount:1,config:null,totals:null},t),null==this.options.config)throw"ScoringRow requires DistanceConfig";this.buildScoringEnds(),this.buildTotalsBlock()}return t.prototype.buildScoringEnds=function(){var t,e,n,s,i,l,r,c;for(this.scoringEnds=[],l=[],t=e=1,n=this.options.endCount;n>=1?n>=e:e>=n;t=n>=1?++e:--e)r=null!=(s=this.endScoresData[t-1])?s:{},c=new o.ScoringEnd({config:this.options.config,cellCount:this.options.cellCount,scores:null!=(i=r.shots)?i:[]}),l.push(this.scoringEnds.push(c));return l},t.prototype.buildTotalsBlock=function(){return this.totalsBlock=new o.ScoringRowTotals({config:this.options.config,scoringEnds:this.scoringEnds,totals:this.options.totals})},t.prototype.toHtml=function(){var t,e,n,s,i,l,r,c,u,a,h,p,f;for(t=o.makeElement(this.options.element,{className:"scoring-row"}),c=this.scoringEnds,e=0,i=c.length;i>e;e++)for(f=c[e],u=f.cells(),n=0,l=u.length;l>n;n++)p=u[n],t.appendChild(p.toHtml());for(a=this.totalsBlock.cells,s=0,r=a.length;r>s;s++)h=a[s],t.appendChild(h.toHtml());return t},t}()}.call(this),function(){o.ScoringRowTotals=function(){function t(t){if(null==t&&(t={}),this.options=Object.assign({config:null,scoringEnds:[],totals:null},t),null==this.options.config)throw"ScoringRow totals requires DistanceConfig";this.scoringEnds=this.options.scoringEnds,this.displayTotals=this.ensureAtLeastOneScoringEnd(),this.buildTotals()}return t.prototype.buildTotals=function(){var t,e,n,s;return n=this.getRowTotalScore(),this.options.totals.totalScore+=n,e=this.getRowTotalHits(),this.options.totals.totalHits+=e,t=this.getRowTotalGolds(),this.options.totals.totalGolds+=t,s=this.getRowTotalX(),this.options.totals.totalX+=s,this.cells=[new o.BasicCell({className:"row-total-score",textContent:this.forDisplay(n)})],this.options.config.withHits&&this.cells.push(new o.BasicCell({className:"row-hits-total",textContent:this.forDisplay(e)})),this.options.config.withGolds&&this.cells.push(new o.BasicCell({className:"row-golds-total",textContent:this.forDisplay(t)})),this.options.config.withX&&this.cells.push(new o.BasicCell({className:"row-x-total",textContent:this.forDisplay(s)})),this.cells.push(new o.BasicCell({className:"row-running-total",textContent:this.forDisplay(this.options.totals.totalScore)}))},t.prototype.cells=function(){return this.cells},t.prototype.ensureAtLeastOneScoringEnd=function(){return this.scoringEnds.filter(function(t){return t.hasAtLeastOneScore()}).length>0},t.prototype.forDisplay=function(t){return this.displayTotals?t.toString():""},t.prototype.getRowTotalGolds=function(){return this.scoringEnds.reduce(function(t,o){return t+o.endTotalCell.totalGolds()},0)},t.prototype.getRowTotalX=function(){return 0},t.prototype.getRowTotalHits=function(){return this.scoringEnds.reduce(function(t,o){return t+o.totalHits()},0)},t.prototype.getRowTotalScore=function(){return this.scoringEnds.reduce(function(t,o){return t+o.totalScore()},0)},t}()}.call(this),function(){var t=function(t,o){function n(){this.constructor=t}for(var s in o)e.call(o,s)&&(t[s]=o[s]);return n.prototype=o.prototype,t.prototype=new n,t.__super__=o.prototype,t},e={}.hasOwnProperty;o.EndTotalCell=function(o){function e(t){var o;if(this.options=null!=t?t:{},null==this.options.config)throw"EndTotalCell requires DistanceConfig";this.scoringCells=null!=(o=this.options.scoringCells)?o:[],e.__super__.constructor.call(this,{className:"end-total-cell",textContent:this.textContent()})}return t(e,o),e.prototype.cellsInUse=function(){return this.scoringCells.filter(function(t){return!t.unused})},e.prototype.endIsScored=function(){var t;return t=this.scoringCells.filter(function(t){return null!=t.scoreValue}),t.length===this.cellsInUse().length},e.prototype.textContent=function(){return this.endIsScored()?this.totalScore().toString():""},e.prototype.totalGolds=function(){var t;return t=this,this.scoringCells.reduce(function(o,e){return o+(e.score()===t.options.config.goldScore?1:0)},0)},e.prototype.totalScore=function(){return this.scoringCells.reduce(function(t,o){return t+o.score()},0)},e}(o.BasicCell)}.call(this),function(){o.Totalizer=function(){function t(t){null==t&&(t={}),this.totalHits=this.totalScore=this.totalPoints=this.totalGolds=this.totalX=0}return t}()}.call(this),function(){}.call(this),function(){}.call(this)}).call(this),"object"==typeof module&&module.exports?module.exports=o:"function"==typeof define&&define.amd&&define(o)}).call(this);