package util;

public class DebugUtil {
    
    public static void printParams(String methodName, Object... params) {
        System.out.println("========== [" + methodName + "] ==========");
        for (int i = 0; i < params.length; i++) {
            System.out.println("param" + (i + 1) + ": [" + params[i] + "]");
        }
        System.out.println("=========================================");
    }
    
    public static void printAdminParams(String adminName, String adminPwd) {
        System.out.println("========== DAO Debug ==========");
        System.out.println("adminName: [" + adminName + "]");
        System.out.println("adminPwd:  [" + adminPwd + "]");
        System.out.println("adminName长度: " + (adminName == null ? "null" : adminName.length()));
        System.out.println("adminPwd长度:  " + (adminPwd == null ? "null" : adminPwd.length()));
        System.out.println("================================");
    }
}
