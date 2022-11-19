package coms363;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.sql.*;

import javax.swing.*;
import javax.swing.border.LineBorder;
/**
 * Author: ComS 363 Teaching Staff
 * Examples of static queries, parameterized queries, and 
 * transactions
 */
/**
 * @author Nedim Hodzic
 * I kept the loginDialog the same and the main method relatively similar. I removed some things like some comments that I didn't write
 * and the Statement and SQLQuery variables since I did not use them anywhere. All of my other methods like the callInsertUser method
 * were written by me using the template as a bit of a guide.
 */
public class tweetsdb {
	/**
	 * 	Asking for a username and password to access the database.
	 *  This code is based off the template file.
	 *  @return An array with the username as the first element and password as the second element.
	 */
	public static String[] loginDialog() {
		String result[] = new String[2];
		JPanel panel = new JPanel(new GridBagLayout());
		GridBagConstraints cs = new GridBagConstraints();

		cs.fill = GridBagConstraints.HORIZONTAL;

		JLabel lbUsername = new JLabel("Username: ");
		cs.gridx = 0;
		cs.gridy = 0;
		cs.gridwidth = 1;
		panel.add(lbUsername, cs);

		JTextField tfUsername = new JTextField(20);
		cs.gridx = 1;
		cs.gridy = 0;
		cs.gridwidth = 2;
		panel.add(tfUsername, cs);

		JLabel lbPassword = new JLabel("Password: ");
		cs.gridx = 0;
		cs.gridy = 1;
		cs.gridwidth = 1;
		panel.add(lbPassword, cs);

		JPasswordField pfPassword = new JPasswordField(20);
		cs.gridx = 1;
		cs.gridy = 1;
		cs.gridwidth = 2;
		panel.add(pfPassword, cs);
		panel.setBorder(new LineBorder(Color.GRAY));

		String[] options = new String[] { "OK", "Cancel" };
		int ioption = JOptionPane.showOptionDialog(null, panel, "Login", JOptionPane.OK_OPTION,
				JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
		
		// store the username in the first element of the array.
		// store the password in the second element of the same array.
		if (ioption == 0) // pressing the OK button
		{
			result[0] = tfUsername.getText();
			result[1] = new String(pfPassword.getPassword());
		}
		
		return result;
	}
	
	/**
	 * This is the method that calls the findPopularHashTags procedure. It takes in the database connection,
	 * the number of values to display, and the what year to choose from.
	 * @param connection
	 * @param k
	 * @param year
	 * @throws SQLException
	 */
	private static void callFindPopularHashTags(Connection connection, String k, String year) throws SQLException {
		String display = "";
		
		//Checks if any values given were null.
		if(connection == null || k == null || year == null) {
			display = "You must enter BOTH a valid k and year.";
			System.out.println(display);
			JOptionPane.showMessageDialog(null, display);
			throw new NullPointerException();
		}
		
		ResultSet result;
		ResultSetMetaData resultMetaData;
		display = "";
		
		connection.setAutoCommit(false);
		connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
		
		//Calls the procedure and sets the input parameters.
		CallableStatement procedure = connection.prepareCall("{call findPopularHashTags(?, ?)}");
		procedure.setInt(1, Integer.parseInt(k));
		procedure.setInt(2, Integer.parseInt(year));
		
		result = procedure.executeQuery();
		resultMetaData = result.getMetaData();
		
		//Adds the results of the query to a string to be printed.
		while(result.next()) {
			for (int i = 0; i < resultMetaData.getColumnCount(); i++) {
				
				display += "| " + result.getString(i + 1) + " ";
			}
			display += "|\n";
		}
		
		
		System.out.println(display);
		JOptionPane.showMessageDialog(null, display);
		
		procedure.close();
	}
	
	/**
	 * This is the method that calls the mostFollowedUsers procedure. It takes in the database connection,
	 * number of values to display, and the political party to to choose from.
	 * @param connection
	 * @param k
	 * @param politicalParty
	 * @throws SQLException
	 */
	private static void callMostFollowedUsers(Connection connection, String k, String politicalParty) throws SQLException {
		String display = "";
		
		//Checks if any given values were null
		if(connection == null || k == null || politicalParty == null) {
			display = "You must enter BOTH a valid k and political party.";
			System.out.println(display);
			JOptionPane.showMessageDialog(null, display);
			throw new NullPointerException();
		}
		
		ResultSet result;
		ResultSetMetaData resultMetaData;
		display = "";
		
		connection.setAutoCommit(false);
		connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
		
		
		//Calls the procedure and sets the input parameters.
		CallableStatement procedure = connection.prepareCall("{call mostFollowedUsers(?, ?)}");
		procedure.setInt(1, Integer.parseInt(k));
		procedure.setString(2, politicalParty);
		
		result = procedure.executeQuery();
		resultMetaData = result.getMetaData();
		
		//Adds the results of the query to a string to be printed.
		while(result.next()) {
			for (int i = 0; i < resultMetaData.getColumnCount(); i++) {
				display += "| " + result.getString(i + 1) + " ";
			}
			
			display += "|\n";
		}
		
		System.out.println(display);
		JOptionPane.showMessageDialog(null, display);
		
		procedure.close();
	}
	
	/**
	 * This is the method that calls the insertUser procedure. It takes in the database connection,
	 * the screen name, user name, category, sub-category, state, number of followers, and the number of following.
	 * @param connection
	 * @param screenName
	 * @param username
	 * @param category
	 * @param subcategory
	 * @param state
	 * @param numFollowers
	 * @param numFollowing
	 */
	private static void callInsertUser(Connection connection, String screenName, String username, String category, String subcategory,
			String state, int numFollowers, int numFollowing) {
		String display = "";
		
		//Checks if the given connection or screen name are null.
		if(connection == null || screenName == null) {
			display = "Check if your connection or the given screen name is empty before inserting.";
			System.out.println(display);
			JOptionPane.showMessageDialog(null, display);
			throw new NullPointerException();
		}
		
		try {
			connection.setAutoCommit(false);
			connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
			
			//Calls the procedure and sets the input parameters.
			CallableStatement procedure = connection.prepareCall("{call insertUser(?, ?, ?, ?, ?, ?, ?, ?)}");
			procedure.setString(1, screenName);
			procedure.setString(2, username);
			procedure.setString(3, category);
			procedure.setString(4, subcategory);
			procedure.setString(5, state);
			procedure.setInt(6, numFollowers);
			procedure.setInt(7, numFollowing);
			procedure.registerOutParameter(8, Types.INTEGER);
			
			procedure.executeUpdate();
			
			//Gets the output from the procedure and displays it.
			int success = procedure.getInt(8);
			display = "Success: " + success + ".";
			System.out.println(display);
			JOptionPane.showMessageDialog(null, display);
			
			//If the output was 1 print a success message.
			if(success == 1) {
				display = "Successfully added " + screenName + ".";
				System.out.println(display);
				connection.commit();
				JOptionPane.showMessageDialog(null, display);
			}
			
			procedure.close();
		}
		catch (SQLException e) {
			//If there is an SQL error where the user could not be inserted print a failure message.
			int success = 0;
			display = "Success: " + success + ".";
			System.out.println(display);
			JOptionPane.showMessageDialog(null, display);
			
			display = "Failed to insert " + screenName + ".\n";
			display += "Check if " + screenName + " is already in the database or for the existence of the insertUser stored procedure";
			System.out.println(display);
			JOptionPane.showMessageDialog(null, display);
		}
	}
	
	/**
	 * This is the method that calls the deleteUser procedure. It takes in the database connection
	 * and the screen name to delete.
	 * @param connection
	 * @param screenName
	 */
	private static void callDeleteUser(Connection connection, String screenName) {
		String display = "";
		
		//Checks if any given values were null
		if(connection == null || screenName == null) {
			display = "Check if your connection or the given screen name is empty before deleting.";
			System.out.println(display);
			JOptionPane.showMessageDialog(null, display);
			throw new NullPointerException();
		}
		
		try {
			connection.setAutoCommit(false);
			connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
			
			//Calls the procedure and sets the input parameters.
			CallableStatement procedure = connection.prepareCall("{call deleteUser(?, ?)}");
			procedure.setString(1, screenName);
			procedure.registerOutParameter(2, Types.INTEGER);
			
			procedure.executeUpdate();
			
			//Gets the output from the procedure and displays it.
			int success = procedure.getInt(2);
			display = "Error code: " + success + ".";
			System.out.println(display);
			JOptionPane.showMessageDialog(null, display);
			
			//If the output was 0 print a success message.
			if(success == 0) {
				display = "Successfully deleted " + screenName + ".";
				System.out.println(display);
				connection.commit();
				JOptionPane.showMessageDialog(null, display);
			}
			//If the output was -1 print a user not found message.
			else if(success == -1) {
				display = screenName + " does not exist.";
				System.out.println(display);
				connection.commit();
				JOptionPane.showMessageDialog(null, display);
			}
			
			procedure.close();
		}
		catch (SQLException e) {
			//If there is an SQL error where the user could not be deleted print a failure message.
			int success = 1;
			display = "Error code: " + success + ".";
			System.out.println(display);
			JOptionPane.showMessageDialog(null, display);
			
			display = "Failed to delete " + screenName + ".\n";
			System.out.println(display);
			JOptionPane.showMessageDialog(null, display);
		}
	}

	public static void main(String[] args) {
		String server = "jdbc:mysql://localhost:3306/practice?useSSL=true";
		String userName = "";
		String password = "";

		// show the login dialog box
		String result[] = loginDialog();
		
		// pass the dialog box to get the result set.
		userName = result[0];
		password = result[1];

		Connection connection = null;
		
		if (result[0] == null || result[1] == null) {
			System.out.println("Terminating: No username nor password is given");
			JOptionPane.showMessageDialog(null, "Terminating: No username nor password is given");
			return;
		}
		
		try {
			// load JDBC driver
			// must be in the try-catch-block
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// establish a database connection with the given username and password
			connection = DriverManager.getConnection(server, userName, password);

			// Menu options
			String option = "";
			String instruction = "a: Run the findPopularHashtags procedure." +
					"\nb: Run the mostFollowedUsers procedure." +
					"\nc: Run the insertUser procedure." +
					"\nd: Run the deleteUser procedure." +
					"\ne: Quit program.";

			while (true) {
				// show the above menu options
				option = JOptionPane.showInputDialog(instruction);
				
				// Reset the autocommit to commit per SQL statement
				// This is for the other SQL queries to be one independently treated as one unit.
				// set the default isolation level to the default.
				connection.setAutoCommit(true);
				connection.setTransactionIsolation(Connection.TRANSACTION_REPEATABLE_READ);
				
				//Call findPopularHashtags, if the user does not enter a value it is set to null.
				if (option.equals("a")) {
					String k = JOptionPane.showInputDialog("Enter the k value: ");
					if(k.equals("")) {
						k = null;
					}
					
					String year = JOptionPane.showInputDialog("Enter the year: ");
					if(year.equals("")) {
						year = null;
					}
					
					callFindPopularHashTags(connection, k, year);
				}
				//Call mostFollowedUsers, if the user does not enter a value it is set to null.
				else if(option.equals("b")) {
					String k = JOptionPane.showInputDialog("Enter the k value: ");
					if(k.equals("")) {
						k = null;
					}
					
					String politicalParty = JOptionPane.showInputDialog("Enter the political party: ");
					if(politicalParty.equals("")) {
						politicalParty = null;
					}
					
					callMostFollowedUsers(connection, k, politicalParty);
				} 
				//Call insertUser, if the user does not enter a value it is set to null.
				else if (option.equals("c")) {
					String screenName = JOptionPane.showInputDialog("Enter the screen name: ");
					if(screenName.equals("")) {
						screenName = null;
					}
					
					String username = JOptionPane.showInputDialog("Enter the username: ");
					if(username.equals("")) {
						username = null;
					}
					
					String category = JOptionPane.showInputDialog("Enter the category: ");
					if(category.equals("")) {
						category = null;
					}
					
					String subcategory = JOptionPane.showInputDialog("Enter the subcategory: ");
					if(subcategory.equals("")) {
						subcategory = null;
					}
					
					String state = JOptionPane.showInputDialog("Enter the state: ");
					if(state.equals("")) {
						state = null;
					}
					
					String followersString = JOptionPane.showInputDialog("Enter the number of followers: ");
					if(followersString.equals("")) {
						followersString = "0";
					}
					int followers = Integer.parseInt(followersString);
					
					String followingString = JOptionPane.showInputDialog("Enter the number following: ");
					if(followingString.equals("")) {
						followingString = "0";
					}
					int following = Integer.parseInt(followingString);
					
					callInsertUser(connection, screenName, username, category, subcategory, state, followers, following);
				}
				//Call deleteUser, if the user does not enter a value it is set to null.
				else if (option.equals("d")) {
					String screenName = JOptionPane.showInputDialog("Enter the screen name: ");
					if(screenName.equals("")) {
						screenName = null;
					}
					
					callDeleteUser(connection, screenName);
				}
				//Exit the program
				else if (option.equals("e")) {
					System.out.println("Exited by user.");
					JOptionPane.showMessageDialog(null, "Exited by user.");
					break;
				}
			}
			
			// close the connection
			if (connection != null) connection.close();
			
		} 
		catch (Exception e) {
			//If the program fails like if a user attempted to insert a null screen name,
			//or an incorrect username or password was submitted display a closing message.
			String display = "Program terminates due to errors or user cancelation";
			System.out.println(display);
			JOptionPane.showMessageDialog(null, display);
		}
	}

}
