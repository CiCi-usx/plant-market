package domain;

public class User {
    private Integer uid;          // 对应 int(11) unsigned NOT NULL AUTO_INCREMENT
    private String uname;         // 对应 varchar(30) NOT NULL
    private String upwd;          // 对应 varchar(50) NOT NULL
    private String usex;          // 对应 varchar(10) DEFAULT NULL
    private String uemail;        // 对应 varchar(50) DEFAULT NULL
    private String phone;         // 对应 varchar(60) DEFAULT NULL
    private String address;       // 对应 varchar(250) DEFAULT NULL

    // 无参构造方法
    public User() {
    }

    // 全参构造方法（不含自增主键 uid，也可以包含）
    public User(String uname, String upwd, String usex, String uemail, String phone, String address) {
        this.uname = uname;
        this.upwd = upwd;
        this.usex = usex;
        this.uemail = uemail;
        this.phone = phone;
        this.address = address;
    }

    // Getter 和 Setter 方法
    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUpwd() {
        return upwd;
    }

    public void setUpwd(String upwd) {
        this.upwd = upwd;
    }

    public String getUsex() {
        return usex;
    }

    public void setUsex(String usex) {
        this.usex = usex;
    }

    public String getUemail() {
        return uemail;
    }

    public void setUemail(String uemail) {
        this.uemail = uemail;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "User{" +
                "uid=" + uid +
                ", uname='" + uname + '\'' +
                ", upwd='" + upwd + '\'' +
                ", usex='" + usex + '\'' +
                ", uemail='" + uemail + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}