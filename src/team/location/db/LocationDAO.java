package team.location.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LocationDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public void getCon() {
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/Ticketlion");
			con = ds.getConnection();

		} catch (Exception err) {
			System.out.println("DB연결에서 오류  : " + err);
		}
	}

	public Vector<LocationListBean> getCategoryLocationList(String l_category,String l_category2) {
		Vector<LocationListBean> v = new Vector<LocationListBean>();
		LocationListBean bean = null;

		try {
			getCon();
			String sql = "select * from location_detail where p_code LIKE '"+l_category+"%' and p_code LIKE '%"+l_category2+"'";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();


			while (rs.next()) {
				bean = new LocationListBean();
				bean.setL_num(rs.getInt(1));
				bean.setP_code(rs.getString(2));
				bean.setL_img(rs.getString(3));
				bean.setL_name(rs.getString(4));
				bean.setL_address(rs.getString(5));
				v.add(bean);
				
			}

		} catch (Exception e) {
			System.out.println("getCategoryLocationList에서 오류 : " + e);
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return v;

	}

	public LocationListBean getOneLocation(int l_num) {
		LocationListBean bean = null;

		try {
			getCon();
			String sql = "select * from location_detail where l_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, l_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean = new LocationListBean();
				bean.setL_num(rs.getInt(1));
				bean.setP_code(rs.getString(2));
				bean.setL_img(rs.getString(3));
				bean.setL_name(rs.getString(4));
				bean.setL_address(rs.getString(5));
			}

		} catch (Exception e) {
			System.out.println("getOneLocation에서 오류 : " + e);
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return bean;
	}

	public Vector<LocationListBean> getAllLocationlist() {
		Vector<LocationListBean> v = new Vector<LocationListBean>();

		LocationListBean bean = null;

		try {
			getCon(); 
			String sql = "select * from location_detail";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				bean = new LocationListBean();
				bean.setL_num(rs.getInt(1));
				bean.setP_code(rs.getString(2));
				bean.setL_img(rs.getString(3));
				bean.setL_name(rs.getString(4));
				bean.setL_address(rs.getString(5));
				v.add(bean);
			}
		} catch (Exception e) {
			System.out.println("getAllLocationlist()에서 오류 : " + e);
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} 
		return v; 
	}
}
