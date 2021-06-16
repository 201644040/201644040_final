package util;

import javax.mail.PasswordAuthentication;
import javax.mail.Authenticator;

public class Gmail extends Authenticator{
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("dwns1020@gmail.com", "milk970403!");
		// 구글 보안 설정에서 보안 수준을 외부에서 연결 가능한 앱 사용하기 설정하고, 아이디와 비밀번호와 변경되지 않았는지 확인
	}
}
