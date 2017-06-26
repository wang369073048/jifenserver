package org.trc.util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by hzwzhen on 2017/6/26.
 */
public class Test2 {

    public static void main(String[] args) throws Exception{
        String inFile = "C:\\Users\\hzwzhen\\Desktop\\crebas.sql";
        String outFile = "C:\\Users\\hzwzhen\\Desktop\\crebas2.sql";
        BufferedReader bs  = null;
        BufferedWriter bw = null;
        try{
            InputStreamReader isr = new InputStreamReader(new FileInputStream(inFile), "GBK");
            bs = new BufferedReader(isr);
            List<String> outData =  new ArrayList<String>();
            String line = null;
            while((line = bs.readLine()) != null){
                if(line.indexOf("InnoDB") < 0 && line.indexOf("MySQL") < 0){
                    line = camelToUnderline(line);
                }
                outData.add(line);
            }
            if(!outData.isEmpty()){
                OutputStreamWriter writerStream = new OutputStreamWriter(new FileOutputStream(outFile),"GBK");
                bw = new BufferedWriter(writerStream);
                for(String s : outData){
                    bw.write(s + "\r\n");
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(bs != null){
                bs.close();
            }
            if(bw != null){
                bw.close();
            }
        }
    }

    public static String camel2Underline(String line){
        if(line==null||"".equals(line)){
            return "";
        }

        line=String.valueOf(line.charAt(0)).toUpperCase().concat(line.substring(1));
        StringBuffer sb=new StringBuffer();

        Pattern pattern=Pattern.compile("[A-Z]([a-z\\d]+)?");
        Matcher matcher=pattern.matcher(line);
        while(matcher.find()){
            String word=matcher.group();
            sb.append(word.toLowerCase());
            sb.append(matcher.end()==line.length()?"":"_");
        }
        return sb.toString();
    }
    public static final char UNDERLINE='_';

    public static String camelToUnderline(String param){
        if (param==null||"".equals(param.trim())){
            return "";
        }
        int len=param.length();
        StringBuilder sb=new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            char c=param.charAt(i);
            if (i> 1 && Character.isUpperCase(c) && Character.isLowerCase(param.charAt(i-1))){
                sb.append(UNDERLINE);
                sb.append(Character.toLowerCase(c));
            }else{
                sb.append(c);
            }
        }
        return sb.toString();
    }

}
