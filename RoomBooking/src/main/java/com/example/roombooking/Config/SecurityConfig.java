package com.example.roombooking.Config;

import com.example.roombooking.Users.Jwt.JwtFilter;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@AllArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final JwtFilter jwtFilter;
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/register", "/authenticate", "/v3/api-docs/**", "/swagger-ui/**", "/swagger-ui.html").permitAll()
                .antMatchers("/rooms/**").hasAnyRole("USER","ADMIN","SUPERADMIN")
                .antMatchers("/admin/**").hasAnyRole("ADMIN","SUPERADMIN")
                .antMatchers("/superadmin/**").hasAuthority("ROLE_SUPERADMIN")
                .and()
                .httpBasic().and() // Basic аутентификация
                .csrf().disable()
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
                .logout();
    }


}