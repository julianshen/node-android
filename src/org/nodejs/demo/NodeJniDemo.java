package org.nodejs.demo;

import org.nodejs.core.NodeJSService;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.webkit.WebView;

public class NodeJniDemo extends Activity {
	WebView mWebView = null;
	
	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		Intent intent = new Intent(this, NodeJSService.class);
		startService(intent);
		
		this.setContentView(R.layout.demo);
		
		mWebView = (WebView) findViewById(R.id.mainWebView);
	}

	@Override
	protected void onResume() {
		super.onResume();
		
		(new Handler()).postDelayed(new Runnable() {

			public void run() {
				mWebView.loadUrl("http://localhost:3000");
			}}, 5000);
		
	}	
}
