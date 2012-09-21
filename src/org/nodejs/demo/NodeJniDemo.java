package org.nodejs.demo;

import android.app.Activity;
import android.os.Bundle;

import org.nodejs.core.NodeJSCore;

public class NodeJniDemo extends Activity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        NodeJSCore.run();
    }
}
