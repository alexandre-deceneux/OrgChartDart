// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library OrgChartDart.base;

import 'dart:html' as html;
import 'dart:js';

class OrgChartDart {

  JsObject  chart;
  String    targetId;

  OrgChartDart([this.targetId = "chart_div"]){
    print("ORGACHARTDART: new chart");
  }

  void  load(){
    print("ORGACHARTDART: load chart");
    var packages = context["packages"];
    new JsObject(context["google"]["load"], ["visualization", "1", {packages:["orgchart"]}]);
    new JsObject(context["google"]["setOnLoadCallback"], [drawChart]);
  }

  void  drawChart([event]){
    print("ORGACHARTDART: Draw chart");

    var data = new JsObject(context["google"]["visualization"]["DataTable"], []);
    data.callMethod("addColumn", ["string", "Name"]);
    data.callMethod("addColumn", ["string", "Manager"]);
    data.callMethod("addColumn", ["string", "ToolTip"]);
    var tab = new JsObject.jsify(
    [
    [{'v':'Mike', 'f':'Mike<div style="color:red; font-style:italic">President</div>'}, '', 'The President'],
    [{'v':'Jim', 'f':'Jim<div style="color:red; font-style:italic">Vice President</div>'}, 'Mike', 'VP'],
    ['Alice', 'Mike', ''],
    ['Carol', 'Jim', ''],
    ['Bob', 'Alice', 'Bob Sponge']
    ]);
    data.callMethod("addRows", [
      tab
    ]);
    var divChart = new JsObject.jsify([html.querySelector("#${targetId}")]);
    chart = new JsObject(context["google"]["visualization"]["OrgChart"], [divChart[0]]);
    chart.callMethod("draw", [data, new JsObject.jsify({'allowHtml':true})]);
  }

}
