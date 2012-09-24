package org.nodejs.demo;

import org.nodejs.core.NodeJSService;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class NodeJniDemo extends Activity {
	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		Intent intent = new Intent(this, NodeJSService.class);
		startService(intent);
	}
}
