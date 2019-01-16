package junit.test;

import java.util.List;

public class Test03 {

	public static void main(String[] args) throws InterruptedException {
		/*String str = null ;
		str = str.toUpperCase();
		System.out.println(str);*/
		
		/*Thread t = null ;
		t.sleep(3000);*/
		
		//Integer i = null ;		
		//int j = i ;  //i.intValue()

		List<String> strList = null ;
		/*for(int i=0; i<strList.size();i++) {
			System.out.println(i);
		}*/
		for (String string : strList) {
			System.out.println(string);
		}
		System.out.println("----------------");
	}

}
