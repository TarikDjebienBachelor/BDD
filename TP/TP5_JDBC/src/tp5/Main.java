package tp5;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
	System.out.println("Licence Informatique\nIntroduction aux Bases de Données Relationnelles\n");
	System.out.println("TP 5 - Introduction à JDBC ");
    System.out.println("Auteurs :\nDJEBIEN Tarik \nYOULHAJEN Jamal dine");
	 
    
    int choixMenu;
	  
	  System.out.println("\n\n=== Menu ===\n\n");
	  System.out.println("1. Exo1: Configuration d'Eclipse et test\n");
	  System.out.println("2. Exo2: Manipulation d'un ResultSet contenant plusieurs lignes\n");
	  System.out.println("3. Exo3: Interaction sur la ligne de commande\n");
	  System.out.println("\nVotre choix ? ");
	  Scanner s = new Scanner(System.in);
	  choixMenu = s.nextInt();
	  
	  
	  System.out.println("\n");
	  
	  switch (choixMenu)
	  {
	    case 1:
	       System.out.println("Vous avez choisi d'executer l'exercice 1 du TP 5!");
	       try {
				Exo1.main(args);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
	       break;
	    case 2:
	       System.out.println("Vous avez choisi d'executer l'exercice 2 du TP 5");
				Exo2.main(args);
	       break;
	    case 3:
	       System.out.println("Vous avez choisi d'executer l'exercice 3 du TP 5");
				Exo3.main(args);
	       break;
	    default:
	       System.out.println("Vous n'avez pas rentre un nombre correct!");
	       break;
	  }
	  System.out.println("\nFIN DU PROGRAMME.\n");
	}

}
