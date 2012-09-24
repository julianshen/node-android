package org.nodejs.demo;

import android.app.Activity;
import android.os.Bundle;

import java.io.IOException;

import org.nodejs.core.NodeJSCore;

public class NodeJniDemo extends Activity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        try {
            NodeJSCore.run(this, "demo.js");
        } catch(IOException e) {
            e.printStackTrace();
        }
    }
}
