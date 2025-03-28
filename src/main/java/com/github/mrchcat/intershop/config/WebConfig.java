package com.github.mrchcat.intershop.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

@Configuration
@ConditionalOnProperty(value = "application.items.load.enabled")
public class WebConfig implements WebMvcConfigurer {

    @Value("${application.items.images.directory}")
    private String IMAGE_DIRECTORY;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        Path imageDirectory = Path.of(IMAGE_DIRECTORY);
        try {
            if (Files.notExists(imageDirectory)) {
                Files.createDirectories(imageDirectory);
            }
            registry.addResourceHandler("/images/**").addResourceLocations("file:" + IMAGE_DIRECTORY);
            WebMvcConfigurer.super.addResourceHandlers(registry);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
