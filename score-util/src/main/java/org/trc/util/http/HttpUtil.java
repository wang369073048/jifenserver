package org.trc.util.http;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HttpUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(HttpUtil.class);
	
	private static final String ENCODING = "UTF-8";
	
	public static HttpRespons post(final String url, final Map<String, Object> data, final Map<String, String> headers) {
		final HttpRespons httpRespons = new HttpRespons();
		HttpResponse response = null;
		try {
			HttpPost post = new HttpPost(url);
			//设置参数
			if ((null != data) && !data.isEmpty()) {
				final List<NameValuePair> formparams = new ArrayList<NameValuePair>();
				for (final String key : data.keySet()) {
					formparams.add(new BasicNameValuePair(key, data.get(key) != null ? data.get(key).toString() : ""));
				}
				final UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(formparams, ENCODING);
				post.setEntity(formEntity);
			}
			//设置header
			if((headers!=null) && (headers.size()>0)){
				for(final String key : headers.keySet()){
					post.addHeader(key, headers.get(key));
				}
			}
			response = HttpClientManager.getHttpClient().execute(post);
			//获得响应
			int code = response.getStatusLine().getStatusCode();
			String content = EntityUtils.toString(response.getEntity(), ENCODING);
			if(code != HttpStatus.SC_OK){
				EntityUtils.consume(response.getEntity());
			}
			httpRespons.setCode(code);
			httpRespons.setContent(content);
			return httpRespons;
		} catch (Exception e) {
			if(response != null){
				try {
					EntityUtils.consume(response.getEntity());
				} catch (IOException e1) {
					logger.error(e1.getMessage(), e1);
				}
			}
			logger.error(e.getMessage(), e);
			return null;
		}
	}
	
	public static HttpRespons get(final String url, final Map<String, Object> data, final Map<String, String> headers) {
		final HttpRespons httpRespons = new HttpRespons();
		HttpResponse response = null;
		try {
			HttpGet get = new HttpGet(url);
			response = HttpClientManager.getHttpClient().execute(get);
			//获得响应
			int code = response.getStatusLine().getStatusCode();
			String content = EntityUtils.toString(response.getEntity(), ENCODING);
			if(code != HttpStatus.SC_OK){
				EntityUtils.consume(response.getEntity());
			}
			httpRespons.setCode(code);
			httpRespons.setContent(content);
			return httpRespons;
		} catch (Exception e) {
			if(response != null){
				try {
					EntityUtils.consume(response.getEntity());
				} catch (IOException e1) {
					logger.error(e1.getMessage(), e1);
				}
			}
			logger.error(e.getMessage(), e);
			return null;
		}
	}
	
	public static HttpRespons tryPost(final String url, final Map<String, Object> data, final Map<String, String> headers) {
		HttpRespons respons = post(url, data, headers);
		if(respons == null){
			int tryNum = 0;
			while(true){
				if(tryNum >= 3){
					break;
				}
				respons = post(url, data, headers);
				tryNum++;
				if(respons == null){
					continue;
				}else{
					return respons;
				}
			}
			return respons;
		}else{
			return respons;
		}
	}
	
	public static HttpRespons postBody(final String url, final String body, final Map<String, String> headers) {
		final HttpRespons httpRespons = new HttpRespons();
		HttpResponse response = null;
		try {
			HttpPost post = new HttpPost(url);
			//设置body
			final StringEntity stringEntity = new StringEntity(body.toString(), ENCODING);
			post.setEntity(stringEntity);
			//设置header
			if((headers!=null) && (headers.size()>0)){
				for(final String key : headers.keySet()){
					post.addHeader(key, headers.get(key));
				}
			}
			response = HttpClientManager.getHttpClient().execute(post);
			//获得响应
			int code = response.getStatusLine().getStatusCode();
			String content = EntityUtils.toString(response.getEntity(), ENCODING);
			if(code != HttpStatus.SC_OK){
				EntityUtils.consume(response.getEntity());
			}
			httpRespons.setCode(code);
			httpRespons.setContent(content);
			return httpRespons;
		} catch (Exception e) {
			if(response != null){
				try {
					EntityUtils.consume(response.getEntity());
				} catch (IOException e1) {
					logger.error(e1.getMessage(), e1);
				}
			}
			logger.error(e.getMessage(), e);
			return null;
		}
	}
	
}
