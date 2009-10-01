package edu.usc.sirlab.db;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseConnection implements Serializable {
	private static final long serialVersionUID = 1L;
	private static final String DB_HOST = "localhost";
	private static final String DB_PORT = "3306";
	private static final String DB_CONNECTION_STRING = "jdbc:mysql://" + DB_HOST + ":" + DB_PORT + "/quaketables";
	private static final String DB_USER = "";
	private static final String DB_PASSWORD = "";
	
	private Connection connection;
	private Statement statement;
	
	public DatabaseConnection() {
	}
	
	public void connect() throws IllegalAccessException, InstantiationException, ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		connection = DriverManager.getConnection(DB_CONNECTION_STRING, DB_USER, DB_PASSWORD);
	}
	
	public ResultSet executeQuery(String query) throws SQLException {
		statement = connection.createStatement();
		statement.execute(query);
		
		return statement.getResultSet();
	}
	
	public PreparedStatement getPreparedStatement(String query) throws SQLException {
		return connection.prepareStatement(query);
	}
	
	public boolean isClosed() throws SQLException {
		return connection.isClosed();
	}
	
	public void close() throws SQLException {
		if(statement != null)
			statement.close();
		connection.close();
	}
}
