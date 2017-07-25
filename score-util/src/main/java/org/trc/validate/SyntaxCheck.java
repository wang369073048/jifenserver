package org.trc.validate;

import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SyntaxCheck {
	/**
	 * 验证手机号码格式
	 * @param mobiles
	 * @return
	 */
	public static boolean phone(String mobiles) {
		Pattern p = Pattern
				//.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");
				.compile("^((13[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$");
		Matcher m = p.matcher(mobiles);
		return m.matches();
	}
	/**
	 * 验证email格式
	 * @param email
	 * @return
	 */
	public static boolean email(String email) {
		Pattern p = Pattern
				.compile("^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w+)+)$");
		Matcher m = p.matcher(email);
		return m.matches();
	}
	/**
	 * 身份证15位编码规则：dddddd yymmdd xx p
	 * dddddd：6位地区编码
	 * yymmdd: 出生年(两位年)月日，如：910215
	 * xx: 顺序编码，系统产生，无法确定
	 * p: 性别，奇数为男，偶数为女
	 *
	 * 身份证18位编码规则：dddddd yyyymmdd xxx y
	 * dddddd：6位地区编码
	 * yyyymmdd: 出生年(四位年)月日，如：19910215
	 * xxx：顺序编码，系统产生，无法确定，奇数为男，偶数为女
	 * y: 校验码，该位数值可通过前17位计算获得
	 *
	 * 前17位号码加权因子为 Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ]
	 * 验证位 Y = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ]
	 * 如果验证码恰好是10，为了保证身份证是十八位，那么第十八位将用X来代替
	 * 校验位计算公式：Y_P = mod( ∑(Ai×Wi),11 )
	 * i为身份证号码1...17 位; Y_P为校验码Y所在校验码数组位置
	 * @param idCard
	 * @return
	 */
	/*public static boolean idCardNo(String idCard) {
		Pattern p = Pattern
				//.compile("(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)");
				.compile("^[1-9]\\d{5}[1-2][1-9]\\d{2}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$");
		Matcher m = p.matcher(idCard);
		return m.matches();
	}*/
	public static boolean idCardNo(String idCard){
		//15位和18位身份证号码的正则表达式
		Pattern p = Pattern
				.compile("^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[X|x])$)$");
		//如果通过该验证，说明身份证格式正确，但准确性还需计算
		Matcher m = p.matcher(idCard);
		if (m.matches()) {
			if (idCard.length()==18) {
				int[] idCardWi={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2}; //将前17位加权因子保存在数组里
				int[] idCardY={1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2}; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
				int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
				int temp = 0;
				for (int i = 0; i < 17; i++) {
					temp = Integer.parseInt(idCard.substring(i, i+1));
					idCardWiSum += temp * idCardWi[i];
				}
				int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
				String idCardLast = idCard.substring(17);//得到最后一位身份证号码
				
				//如果等于2，则说明校验码是10，身份证号码最后一位应该是X
				if (idCardMod == 2) {
					if ("X".equalsIgnoreCase(idCardLast)) {
						return true;
					}
				} else {
					// 用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
					try {
						if (Integer.parseInt(idCardLast) == idCardY[idCardMod]) {
							return true;
						}
					} catch (Exception e) {
						return false;
					}
				}
			}
		}
		return false;
	}
	/**
	 * 验证密码格式
	 * 六位以上二十位以下
	 * @param passwords
	 * @return
	 */
	public static boolean password(String passwords) {
		if (passwords.length()<6 || passwords.length()>20) {
			return false;
		}
		return true;
	}
	/**
	 * 验证学信ID
	 * 5-50个字符
	 * @param id
	 * @return
	 */
	public static boolean xuexinId(String id) {
		if (id==null) {
			return false;
		}
		if (id.length()<5 || id.length()>50) {
			return false;
		}
		return true;
	}
	/**
	 * 验证学信密码
	 * 6-30个字符
	 * @param pwd
	 * @return
	 */
	public static boolean xuexinPwd(String pwd) {
		if (pwd==null) {
			return false;
		}
		if (pwd.length()<6 || pwd.length()>30) {
			return false;
		}
		return true;
	}
	/**
	 * 验证验证码格式
	 * 四位数字
	 * @param code
	 * @return
	 */
	public static boolean verCode(String code) {
		Pattern p = Pattern.compile("^\\d{4}$");
		Matcher m = p.matcher(code);
		return m.matches();
	}
	/**
	 * 验证年份格式
	 * 年份为4位数字
	 * @param year
	 * @return
	 */
	public static boolean verYear(String year) {
		Pattern p = Pattern.compile("^\\d{4}$");
		Matcher m = p.matcher(year.trim());
		return m.matches();
	}
	/**
	 * 验证入学时间
	 * 入学时间为当前年至当前年份-10年
	 * @param year
	 * @return
	 */
	public static boolean verStartYear(String year) {
		year = year.trim();
		int intYear = Integer.parseInt(year);
		Calendar calendar = Calendar.getInstance();
		int currentYear = calendar.get(Calendar.YEAR);
		if (currentYear-intYear<=10 && currentYear-intYear>=0) {
			return true;
		}
		return false;
	}
	/**
	 * 验证毕业时间
	 * 毕业时间为当前年至当前年份+10年
	 * @param year
	 * @return
	 */
	public static boolean verEndYear(String year) {
		year = year.trim();
		int intYear = Integer.parseInt(year);
		Calendar calendar = Calendar.getInstance();
		int currentYear = calendar.get(Calendar.YEAR);
		if (intYear-currentYear<=10&&intYear-currentYear>=0) {
			return true;
		}
		return false;
	}
	/**
	 * 验证毕业时间（规则二）
	 * 毕业时间为当前年至当前年份+10年
	 * @param year
	 * @return
	 */
	public static boolean verGraduateYear(String year) {
		year = year.trim();
		int intYear = Integer.parseInt(year);
		Calendar calendar = Calendar.getInstance();
		int currentYear = calendar.get(Calendar.YEAR);
		if (intYear-currentYear<=10&&intYear-currentYear>=0) {
			return true;
		}
		return false;
	}
}
