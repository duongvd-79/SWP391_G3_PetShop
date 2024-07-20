package helper;

import jakarta.servlet.http.Part;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

public class PartForm {

    public static String getValueFromPart(Part part) throws IOException {
        if (part != null) {
            StringBuilder value = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8))) {
                char[] buffer = new char[1024];
                int length;
                while ((length = reader.read(buffer)) > 0) {
                    value.append(buffer, 0, length);
                }
            }
            return value.toString();
        }
        return null; // or return an empty string or handle the null case accordingly
    }
}
