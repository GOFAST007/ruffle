/* -*- Mode: java; tab-width: 8; indent-tabs-mode: nil; c-basic-offset: 4 -*-
 *
 * ***** BEGIN LICENSE BLOCK *****
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
package {
public class Test {}
}

import com.adobe.test.Assert;

function START(summary)
{
      // print out bugnumber

     /*if ( BUGNUMBER ) {
              writeLineToLog ("BUGNUMBER: " + BUGNUMBER );
      }*/
    XML.setSettings (null);
    testcases = new Array();

    // text field for results
    tc = 0;
    /*this.addChild ( tf );
    tf.x = 30;
    tf.y = 50;
    tf.width = 200;
    tf.height = 400;*/

    //_print(summary);
    var summaryParts = summary.split(" ");
    //_print("section: " + summaryParts[0] + "!");
    //fileName = summaryParts[0];

}

function TEST(section, expected, actual)
{
    AddTestCase(section, expected, actual);
}
 

function TEST_XML(section, expected, actual)
{
  var actual_t = typeof actual;
  var expected_t = typeof expected;

  if (actual_t != "xml") {
    // force error on type mismatch
    TEST(section, new XML(), actual);
    return;
  }

  if (expected_t == "string") {

    TEST(section, expected, actual.toXMLString());
  } else if (expected_t == "number") {

    TEST(section, String(expected), actual.toXMLString());
  } else {
    reportFailure ("", 'Bad TEST_XML usage: type of expected is "+expected_t+", should be number or string');
  }
}

function reportFailure (section, msg)
{
  trace("~FAILURE: " + section + " | " + msg);
}

function AddTestCase( description, expect, actual ) {
   testcases[tc++] = Assert.expectEq(description, "|"+expect+"|", "|"+actual+"|" );
}

function myGetNamespace (obj, ns) {
    if (ns != undefined) {
        return obj.namespace(ns);
    } else {
        return obj.namespace();
    }
}




function NL()
{
  //return java.lang.System.getProperty("line.separator");
  return "\n";
}


function BUG(arg){
  // nothing here
}

function END()
{
    //test();
}

START("13.3.5 - Properties of QName Instances");

q = new QName("http://someuri", "foo");
TEST(1, true, q.hasOwnProperty("localName"));
TEST(2, true, q.hasOwnProperty("uri"));
//TEST(3, true, q.propertyIsEnumerable("localName"));
//TEST(4, true, q.propertyIsEnumerable("uri"));

var localNameCount = 0;
var uriCount = 0;
var p;
for(p in q)
{
    if(p == "localName") localNameCount++;
    if(p == "uri") uriCount++;
}

TEST(5, 1, localNameCount);
TEST(6, 1, uriCount);
TEST(7, "http://someuri", q.uri);
TEST(8, "foo", q.localName);

qn = new QName("validname");
Assert.expectEq( "QName.localName", "validname", qn.localName);

qn = new QName("http://www.w3.org/TR/html4/", "validname");
Assert.expectEq( "QName.localName", "validname", qn.localName);

qn = new QName("validname");
Assert.expectEq( "qn = new QName('validname'), QName.uri", "", qn.uri);

qn = new QName(null, "validname");
Assert.expectEq( "qn = new QName(null, 'validname'), QName.uri", null, qn.uri);

qn = new QName("http://www.w3.org/TR/html4/", "validname");
Assert.expectEq( "QName.uri", "http://www.w3.org/TR/html4/", qn.uri);

qn = new QName("", "validname");
Assert.expectEq( "qn = new QName('', 'validname'), QName.uri", "", qn.uri);


END();