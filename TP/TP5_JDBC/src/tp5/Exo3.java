package tp5;
import java.sql.*;
import java.util.Scanner;

public class Exo3 {


	public static void main(String[] args) {
		
		try{
		    Class.forName("oracle.jdbc.driver.OracleDriver");}
		catch(ClassNotFoundException x){
		    System.out.println("Driver could not be loaded");}
		
		System.out.println("Exercice 3 - Interaction sur la ligne de commande.\n");
		System.out.println("\n---Connectivité au serveur Oracle---\n");
		Scanner s = new Scanner(System.in);
		System.out.print("UserName : ");
		String userName = s.nextLine();
		System.out.print("\n");

		System.out.print("PassWord : ");
		String passWord = s.nextLine();
		System.out.print("\n");
		
		
        
        Exo2 monExercice3 = new Exo2(userName,passWord);
        
        
        if (monExercice3.getConnection() != null){
        	System.out.println("Connexion au serveur Oracle . . .\nConnexion établie.");
			try {
				boolean ok = true;
				do{
				System.out.println("\nNumero du patient : ");
				int x = s.nextInt();
				System.out.println("\n");
				monExercice3.quiASoigne(x);
				System.out.print("\nSouhaitez vous selectionner un autre patient (oui/non) : ");
				Scanner r = new Scanner(System.in);
				String reponseClient = r.nextLine();
				System.out.print("\n");
				ok = (reponseClient.equalsIgnoreCase("oui"))?true:false;
				}while(ok);
			} catch (SQLException e) {
				System.out.println("Erreur dans la methode quiASoigne()");
				e.printStackTrace();
			} 
		monExercice3.closeConnexion(monExercice3.getConnection());
		System.out.println("Déconnexion de la base. . .\n"+userName+" deconnecté.");
        }
	}

}
