package com.unknown.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.unknown.model.MemberVO;
import com.unknown.service.MemberService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberservice;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	// �Ϲ� ȸ�� ���� ������ �̵�
	@RequestMapping(value = "/normalAuth", method = RequestMethod.GET)
	public void nomalAuthGET() {

		logger.info("�Ϲ� ȸ������ ���� ������ ����");

	}

	// �̸��� ���� ������ �̵�
	@RequestMapping(value = "/mail", method = RequestMethod.GET)
	public void mailGET() {
		logger.info("�̸��� ���� ������ ����");
	}

	// �̸��� ���� ó��
	public void verifyEmail(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email"); // ���ǿ��� �̸��� ���� ������
		session.setAttribute("verifiedEmail", email); // �̸��� �ּҸ� ���ǿ� ����
	}

	// �̿��� ���� ������ �̵�
	@RequestMapping(value = "/easyGeneral", method = RequestMethod.GET)
	public void easyGeneralGET() {
		logger.info("�̿��� ���� ������ ����");
	}

	// ȸ������ ������ �̵�
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void loginGET() {

		logger.info("ȸ������ ���� �Է� ������ ����");

	}

	// ȸ������
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPOST(MemberVO member) throws Exception {

		String rawPw = ""; // ���ڵ� �� ��й�ȣ
		String encodePw = ""; // ���ڵ� �� ��й�ȣ

		rawPw = member.getMemberPw(); // ��й�ȣ ������ ����
		encodePw = pwEncoder.encode(rawPw); // ��й�ȣ ���ڵ�
		member.setMemberPw(encodePw); // ���ڵ��� ��й�ȣ member��ü�� �ٽ� ����

		/* ȸ������ ���� ���� */
		memberservice.memberJoin(member);

		return "redirect:/main";

	}

	// �α��� ������ �̵�
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void joinGET() {

		logger.info("�α��� ������ ����");

	}

	// ���̵� �ߺ� �˻�
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String memberId) throws Exception {

		// logger.info("memberIdChk() ����");

		logger.info("memberIdChk() ����");

		int result = memberservice.idCheck(memberId);

		logger.info("����� = " + result);

		return result != 0 ? "fail" : "success";

	} // memberIdChkPOST() ����

	/* ���� �߼� */
	@RequestMapping(value = "/sendMail", method = RequestMethod.GET)
	public void sendMailTest() throws Exception {

		String subject = "test ����";
		String content = "���� �׽�Ʈ ����";
		String from = "dhkim0147@naver.com";
		String to = "dhkim9298@naver.com";

		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			// true�� ��Ƽ��Ʈ �޼����� ����ϰڴٴ� �ǹ�

			/*
			 * �ܼ��� �ؽ�Ʈ �޼����� ���ÿ� �Ʒ��� �ڵ嵵 ��� ���� MimeMessageHelper mailHelper = new
			 * MimeMessageHelper(mail,"UTF-8");
			 */

			mailHelper.setFrom(from);
			// �� ���̵� ������ ���� �ܼ��� smtp ������ �ޱ� ���� ��� ���� ��������(setFrom())�ݵ�� �ʿ�
			// �������̿� �����ּҸ� �����ϴ��̰� ���� ��� ǥ�� �ǰ� ���� ��� �Ʒ��� �ڵ带 ���
			// mailHelper.setFrom("�������� �̸� <�������� ���̵�@�������ּ�>");
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(content, true);
			// true�� html�� ����ϰڴٴ� �ǹ��Դϴ�.

			/*
			 * �ܼ��� �ؽ�Ʈ�� ����ϴ� ��� ������ �ڵ带 ��� ���� mailHelper.setText(content);
			 */

			mailSender.send(mail);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/* �̸��� ���� */
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {

		/* ��(View)�κ��� �Ѿ�� ������ Ȯ�� */
		logger.info("�̸��� ������ ���� Ȯ��");
		logger.info("������ȣ : " + email);

		/* ������ȣ(����) ���� */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		logger.info("������ȣ " + checkNum);

		/* �̸��� ������ */
		String setFrom = "dhkim0147@naver.com";
		String toMail = email;
		String title = "ȸ������ ���� �̸��� �Դϴ�.";
		String content = "Ȩ�������� �湮���ּż� �����մϴ�." + "<br><br>" + "���� ��ȣ�� " + checkNum + "�Դϴ�." + "<br>"
				+ "�ش� ������ȣ�� ������ȣ Ȯ�ζ��� �����Ͽ� �ּ���.";

		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

		String num = Integer.toString(checkNum);

		return num;

	}

	/* �α��� */
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {
	    HttpSession session = request.getSession();
	    String rawPw = "";
	    String encodePw = "";

	    MemberVO lvo = memberservice.memberLogin(member); // ������ ���̵�� ��ġ�ϴ� ���̵� �ִ���

	    if (lvo != null) { // ��ġ�ϴ� ���̵� ���� ��
	        rawPw = member.getMemberPw(); // ����ڰ� ������ ��й�ȣ
	        encodePw = lvo.getMemberPw(); // �����ͺ��̽��� ������ ���ڵ��� ��й�ȣ

	        if (pwEncoder.matches(rawPw, encodePw)) { // ��й�ȣ ��ġ ���� �Ǵ�
	            lvo.setMemberPw(""); // ���ڵ��� ��й�ȣ ���� ����
	            session.setAttribute("member", lvo); // session�� ������� ���� ����
	            session.setAttribute("memberId", lvo.getMemberId()); // ���ǿ� memberId �߰�
	            session.setAttribute("point", lvo.getPoint());
	            session.setAttribute("adminCk", lvo.getAdminCk()); // ���ǿ� adminCk �߰�

	            // adminCk ���� Ȯ���Ͽ� �������� ��� ó��
	            if (lvo.getAdminCk() == 1) {
	                session.setAttribute("isAdmin", true);
	                System.out.println("�����ڷ� �α��εǾ����ϴ�. adminCk: " + lvo.getAdminCk());
	            } else {
	                System.out.println("����ڷ� �α��εǾ����ϴ�. adminCk: " + lvo.getAdminCk());
	            }

	            return "redirect:/main"; // ���� �������� �̵�
	        } else {
	            rttr.addFlashAttribute("result", 0);
	            return "redirect:/member/login"; // �α��� �������� �̵�
	        }
	    } else { // ��ġ�ϴ� ���̵� �������� ���� �� (�α��� ����)
	        rttr.addFlashAttribute("result", 0);
	        return "redirect:/member/login"; // �α��� �������� �̵�
	    }
	}


	/* ���������� �α׾ƿ� */
	@RequestMapping(value = "logout.do", method = RequestMethod.GET)
	public String logoutMainGET(HttpServletRequest request) throws Exception {

		logger.info("logoutMainGET�޼��� ����");

		HttpSession session = request.getSession();

		session.invalidate();

		return "redirect:/main";

	}

	/* �񵿱��� �α׾ƿ� �޼��� */
	@RequestMapping(value = "logout.do", method = RequestMethod.POST)
	@ResponseBody
	public void logoutPOST(HttpServletRequest request) throws Exception {

		logger.info("�񵿱� �α׾ƿ� �޼��� ����");

		HttpSession session = request.getSession();

		session.invalidate();

	}

	// ȸ������ ������ �̵�
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void memberUpdate() {

		logger.info("ȸ������ ���� ����");

	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String memberUpdatePOST(@RequestBody MemberVO member) throws Exception {
	    // �α׸� ���� ���޵� �����͸� Ȯ��
	    logger.info("������Ʈ�� ȸ�� ����: {}", member);

	    // ��й�ȣ�� ��� ���� ���� ��쿡�� ���ڵ��Ͽ� ����
	    if (member.getMemberPw() != null && !member.getMemberPw().isEmpty()) {
	        String rawPw = member.getMemberPw(); // ���ڵ� �� ��й�ȣ
	        String encodePw = pwEncoder.encode(rawPw); // ��й�ȣ ���ڵ�
	        member.setMemberPw(encodePw); // ���ڵ��� ��й�ȣ�� ����
	    }

	    // ȸ�� ���� ���� ����
	    memberservice.memberUpdate(member);
	    return "redirect:/main";
	}

}
