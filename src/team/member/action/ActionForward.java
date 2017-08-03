package team.member.action;


/*
ActionForward Ŭ������ Action �������̽����� ����� �����ϰ�
��� ���� ������ �������� ������(�̵�)�Ҷ� ���Ǵ� Ŭ������.

 �ϴ� ��1. ������ �̵���� ���� �� ������ �������ִ� ����.
  		������ �̵���� ���ΰ� true�϶� -> Response.sendRedirect() ���
  		ü���� �̵���� ���ΰ� false�϶� -> forward() ���
 
�ϴ� ��2. �̵������� ��� �� �����Ͽ� �������ִ� ����
  
 */
public class ActionForward {
	
	//������ �̵� ��� ���� �� ������ ���� ����
	private boolean isRedirect = false;
	
	//true sendRedirect() 	<- �� ����� �̵��� ������ �ּ� ��� ������.
	//false forward() 		<- �� ����� �̵��� ������ �ּ� ��� ���� ����.

	//�̵� ������ ��� �ּӹ� ���� ����
	private String path = null;
	
	//������ �̵� ��� ���ΰ� �����ϴ� �޼ҵ�
	public void setRedirect(boolean isRedirect){
		this.isRedirect = isRedirect;
	}
	
	//������ �̵� ��� ���ΰ� ���� �޼ҵ�
	public boolean isRedirect(){
		return isRedirect;
	}
	
	//�̵��� ������ ��� �ּҰ��� ������ �޼ҵ�
	public void setPath(String path){
		this.path=path;
	}
	
	//�̵��� ������ ��� �ּҰ� �����ϴ� �޼ҵ�
	public String getPath(){
		return path;
	}
	
	
	
}


















