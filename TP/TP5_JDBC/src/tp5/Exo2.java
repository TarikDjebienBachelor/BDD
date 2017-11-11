package tp5;
import java.sql.*;

public class Exo2 {

    private String identifiant;
    private String motdePass;
    private Connection connection;
	
    
    
	public Exo2(String identifiant, String motdePass) {
	
		this.identifiant = identifiant;
		this.motdePass = motdePass;
		try {
			this.connection = DriverManager.getConnection("jdbc:oracle:thin:@orval.fil.univ-lille1.fr:1521:filora10gr2",identifiant,motdePass);
		} catch (SQLException e) {
			this.connection = null;
			System.out.println("Connexion au serveur Oracle . . .\n");
			System.out.println("Error : impossible de se connecter à la base.");
			//e.printStackTrace();
		}
	}

	 
	/**
	 * @return the connection
	 */
	public Connection getConnection() {
		return connection;
	}

	
	public void closeConnexion(Connection c) {
		try {
			c.close();
		} catch (SQLException e) {
			System.out.println("Error : la fermeture de la connection ne s'est pas correctement déroulée.");
			e.printStackTrace();
		}
	}

	/**
	 * @return the identifiant
	 */
	public String getIdentifiant() {
		return this.identifiant;
	}

	/**
	 * @param identifiant the identifiant to set
	 */
	public void setIdentifiant(String identifiant) {
		this.identifiant = identifiant;
	}

	/**
	 * @return the motdePass
	 */
	public String getMotdePass() {
		return motdePass;
	}

	/**
	 * @param motdePass the motdePass to set
	 */
	public void setMotdePass(String motdePass) {
		this.motdePass = motdePass;
	}

	public ResultSet executerRequete(String q) throws SQLException{
		PreparedStatement p = this.getConnection().prepareStatement(q);		
		p.clearParameters();
		ResultSet r = p.executeQuery();
		return r;
	}
		
	
	public void quiASoigne(int numpat) throws SQLException{

	    ResultSet CurSejour = this.executerRequete("SELECT entree,sortie FROM SEJOURS WHERE SEJOURS.numpat="+numpat);
	    String sejourDebut, 
	           sejourFin,
	           IdMedecin,
	           dateDeSoin;
	    
	    
	    ResultSet s = this.executerRequete("select PATIENTS.nom from PATIENTS where PATIENTS.numpat="+numpat);
	    while ( s.next() ) {
	        System.out.println(s.getString(1)+" a été soigné durant : ");
	    }
	
        
	    while(CurSejour.next()){
	     sejourDebut = CurSejour.getString(1);
	     sejourFin = CurSejour.getString(2);
	     System.out.println("\n  Le sejour du "+sejourDebut+" au "+sejourFin+" : ");
		 ResultSet CurSoin = this.executerRequete(
				            "SELECT numed,date_soin FROM SOINS WHERE SOINS.numpat="+numpat
				            +"AND to_date(SOINS.date_soin,'DD/MM/YYYY')"
				            +"BETWEEN to_date('"+sejourDebut+"','DD/MM/YYYY')"
				            +"AND to_date('"+sejourFin+"','DD/MM/YYYY')"
				            );
		 
	     while(CurSoin.next()){
           IdMedecin = CurSoin.getString(1);
           dateDeSoin = CurSoin.getString(2);
           ResultSet r = this.executerRequete("select MEDECINS.nom from MEDECINS where MEDECINS.numed="+IdMedecin);
           while(r.next())
           System.out.println("   - le "+dateDeSoin+" par le medecin "+r.getString(1));
	     }
	    }	

	}
	
	public static void main(String[] args) {
		try{
		    Class.forName("oracle.jdbc.driver.OracleDriver");}
		catch(ClassNotFoundException x){
		    System.out.println("Driver could not be loaded");}
        System.out.println("Exercice 2 - Manipulation d'un ResultSet contenant plusieurs lignes.\n");
        Exo2 monExercice2 = new Exo2("youlhajen","youlhajen");
        if (monExercice2.getConnection() != null)
			try {
				monExercice2.quiASoigne(1);
			} catch (SQLException e) {
				System.out.println("Erreur dans la methode quiASoigne()");
				e.printStackTrace();
			}
		monExercice2.closeConnexion(monExercice2.getConnection());	
	}

}
